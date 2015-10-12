module Importer

  def self.import_all
    import_employees
    import_teachers
    import_education_subjects
    import_courses
    import_students
    import_carriers
  end

  def self.encrypt_string(string)
    return unless string.present?
    Rails.env.production? ? string : 'GEBLOCKT'
  end

  def self.encrypt_email(email)
    return unless email.present?
    first, last = email.split '@'
    first = Digest::MD5.hexdigest first
    [first, last].join '@'
  end

  def self.import_employees
    puts 'import employees'

    LegacyDatum.where(old_table: 'mitarbeiter').all.each do |legacy_datum|
      data = legacy_datum.data

      employee            = Employee.new
      employee.first_name = data['vorname']
      employee.last_name  = data['nachname']
      employee.email      = data['email']
      employee.save!

      employee.create_login!

      ActiveRecord::Base.connection.reset_pk_sequence!(Person.table_name)
    end

  end

  def self.import_education_subjects
    puts 'import education_subjects'
    LegacyDatum.where(old_table: 'ausbildungsart').all.each do |legacy_datum|
      data = legacy_datum.data

      education_subject            = EducationSubject.new
      education_subject.id         = data['id']
      education_subject.name       = data['name']
      education_subject.short_name = data['shortname']

      education_subject.save!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(EducationSubject.table_name)

  end

  def self.import_teachers
    puts 'import teachers'
    LegacyDatum.where(old_table: 'lehrer').all.each do |legacy_datum|
      data = legacy_datum.data

      teacher            = Teacher.new
      teacher.id         = data['id']
      teacher.email      = encrypt_email(data['email'])
      teacher.first_name = data['vorname']
      teacher.last_name  = data['nachname']
      teacher.gender     = data['geschlecht'].to_i == 1 ? 'f' : 'm'

      teacher.save!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Teacher.table_name)
  end

  def self.import_courses
    puts 'import courses'
    LegacyDatum.where(old_table: 'klassen').all.each do |legacy_datum|
      data = legacy_datum.data

      course                      = Course.new
      course.id                   = data['id']
      course.education_subject_id = data['ausbildungsart_id']
      course.name                 = data['name']
      course.teacher_id           = data['lehrer_id']
      course.start_date           = data['start_date']
      course.end_date             = data['end_date']
      course.save!
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Course.table_name)
  end

  def self.import_students
    puts 'import students'
    LegacyDatum.where(old_table: 'azubi').all.each do |legacy_datum|
      data = legacy_datum.data
      begin
        student            = Student.new
        student.first_name = data['vorname']
        student.last_name  = data['nachname']
        student.email      = encrypt_email(data['email'])
        student.gender     = data['geschlecht'].to_i == 1 ? 'f' : 'm'
        street, number     = data['strasse'], data['hausnummer']
        street             += (" #{number}") if number.present?
        student.street     = encrypt_string street
        student.zip        = data['plz']
        student.city       = data['ort']
        student.phone      = encrypt_string data['telefon']
        student.save!

        # generate_course_membership student, data
        course     = Course.where(id: data['klasse']).first
        membership = student.course_memberships.create! course: course if course

      rescue StandardError => e
        msg = "Student #{data['id']} (#{data['vorname']} #{data['nachname']}): "
        msg += student.errors.full_messages.join(', ')
        puts msg
      end

      # bundesland: Sachsen-Anhalt
      # landkreis: LK Harz
      # pp: 191
      # anleiter_id: 68
    end

    ActiveRecord::Base.connection.reset_pk_sequence!(Student.table_name)
    ActiveRecord::Base.connection.reset_pk_sequence!(CourseMembership.table_name)
  end

  def self.import_carriers
    puts 'import carriers'
    LegacyDatum.where(old_table: 'traeger').all.each do |legacy_datum|
      data = legacy_datum.data
      carrier                = Carrier.new
      carrier.id             = data['id']
      carrier.name           = data['name_1']
      carrier.email          = encrypt_string data['email']
      street, number         = data['strasse'], data['hausnummer']
      street                 += (" #{number}") if number.present?
      carrier.street         = encrypt_string street
      carrier.zip            = data['plz']
      carrier.city           = data['ort']
      carrier.phone          = encrypt_string data['telefon']
      carrier.fax            = encrypt_string data['telefax']
      carrier.contact_person = encrypt_string "#{data['vorname']} #{data['nachname']}"
      carrier.homepage       = data['homepage']
      carrier.comments       = encrypt_string data['kurzbeschreibung']
      carrier.save!
      # geschlecht: 1
    end


    ActiveRecord::Base.connection.reset_pk_sequence!(Carrier.table_name)
  end

  def self.import_time_blocks
    puts 'import time blocks'

    TimeBlock.delete_all

    TimeBlock.create! [
        {start_time:  '8:00', end_time:  '9:30', position: 1, active: true}, # 08.00 bis 09.30 Uhr
        {start_time:  '9:45', end_time: '11:15', position: 2, active: true}, # 09.45 bis 11.15 Uhr
        {start_time: '11:30', end_time: '13:00', position: 3, active: true}, # 11.30 bis 13.00 Uhr
        {start_time: '13:30', end_time: '15:00', position: 4, active: true}, # 13.30 bis 15.00 Uhr
        {start_time: '15:15', end_time: '16:45', position: 5, active: true}, # 15.15 bis 16.45 Uhr
      ]

    ActiveRecord::Base.connection.reset_pk_sequence!(TimeBlock.table_name)
  end


end
