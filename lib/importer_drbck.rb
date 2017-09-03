require 'csv'

module ImporterDrbck

  COURSES_SQL = <<-SQL
    SELECT
      k.klassen_id id,
      k.klassen_name name,
      k.klassen_lehrer teacher_id,
      k.klassen_beginn start_date,
      k.klassen_ende end_date
    FROM klassen AS k
    WHERE k.klassen_ausbildungsart IN (1, 2)
  SQL

  STUDENTS_SQL = <<-SQL
    SELECT
      a.azubi_id id,
      a.azubi_email email,
      a.azubi_geschlecht gender,
      a.azubi_vorname first_name,
      a.azubi_nachname last_name,
      a.azubi_strasse street,
      a.azubi_hausnummer number,
      a.azubi_plz zip,
      a.azubi_ort city,
      a.azubi_telefon phone,
      a.azubi_klasse course_id
    FROM `azubi` AS a
      JOIN klassen AS k ON a.azubi_klasse = k.klassen_id
    WHERE k.klassen_ausbildungsart IN (1, 2)
  SQL

  TEACHERS_SQL = <<-SQL
    SELECT
      l.lehrer_id id,
      l.lehrer_vorname first_name,
      l.lehrer_nachname last_name,
      l.lehrer_email email,
      l.lehrer_geschlecht gender
    FROM lehrer AS l
      JOIN klassen AS k ON l.lehrer_id = k.klassen_lehrer
    WHERE k.klassen_ausbildungsart IN (1, 2)
  SQL

  def self.import_all
    teachers = import_teachers
    courses  = import_courses teachers
    students = import_students courses
    [teachers, courses, students]
  end

  # def self.delete_all
  #   [CourseMembership, Student, Course, Teacher, Person].each do |model|
  #     model.delete_all
  #     ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
  #   end
  # end

  def self.import_teachers
    puts 'import teachers'

    teachers = {}
    CSV.foreach(Rails.root.join('tmp/lehrer.csv'), headers: true) do |teacher|
      teacher            = teacher.to_h
      id                 = teacher.delete('id').to_i
      teacher['contact'] = { email: teacher.delete('email') }
      teachers[id]       = Person.create!(teacher).create_as_teacher!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Person.table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(Teacher.table_name)
    teachers
  end

  def self.import_courses(teachers)
    puts 'import courses'

    courses = {}
    CSV.foreach(Rails.root.join('tmp/klassen.csv'), headers: true) do |course|
      course              = course.to_h
      id                  = course.delete('id').to_i
      course[:teacher]    = teachers[course.delete('teacher_id').to_i]
      course[:start_date] = date(course.delete('start_date'))
      course[:end_date]   = date(course.delete('end_date'))
      courses[id]         = Course.create! course
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Course.table_name)
    courses
  end

  def self.import_students(courses)
    puts 'import students'

    students = {}
    CSV.foreach(Rails.root.join('tmp/azubi.csv'), headers: true) do |student|
      student           = student.to_h
      id                = student.delete('id').to_i
      course_id         = student.delete('course_id').to_i
      student['gender'] = student['gender'].to_i == 1 ? 'f' : 'm'
      student[:contact] = { email: student.delete('email'), phone: student.delete('phone') }
      student[:address] = address(student)
      student.delete 'start'
      students[id] = Person.create!(student).create_as_student!(course: courses[course_id], active: true)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Person.table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(CourseMembership.table_name)
    students
  end

  def self.date(timestamp)
    DateTime.strptime(timestamp, '%s').to_date
  end

  def self.address(row)
    {
      street: [row.delete('street'), row.delete('number')].join(' ').strip,
      city:   row.delete('city'),
      zip:    row.delete('zip'),
    }
  end
end
