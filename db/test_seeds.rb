# Importer.import_all
# Importer.load_from_csv
# x Importer.import_schools
# x Importer.import_education_subjects
# x Importer.import_managers
# x Importer.import_teachers
# x Importer.import_courses
# Importer.import_students
# Importer.import_carriers
# Importer.import_internship_positions
# Importer.generate_student_logins
[
  # Login,
  InternshipPosition,
  CourseMembership,
  Course,
  Organisation,
  Person,
  EducationSubject
].each(&:destroy_all)

# EducationSubject.create!(name: 'Gardening',  short_name: 'GA')
# EducationSubject.create!(name: 'Plumbing',   short_name: 'PL')
# EducationSubject.create!(name: 'Touristing', short_name: 'TO')

# John is manager and teacher on School1
john = Person.create!(first_name: 'John', last_name: 'Maker', contact: { email: 'john@bak.er' })
LoginGenerator.new(john, password: 'johnmaker').call(send_email: false)
School.add_manager! john
School.add_teacher! john

# Sofia is manager on School1
{ first_name: 'Sofia', last_name: 'Gentle', contact: { email: 'sofia@gent.le' } }
sofia = Person.create!(first_name: 'Sofia', last_name: 'Gentle', contact: { email: 'sofia@gent.le' })
LoginGenerator.new(sofia, password: 'sofiagentle').call(send_email: false)
School.add_manager! sofia

# Other teachers
teachers = [
  { first_name: 'Maria', last_name: 'Silver', contact: { email: 'm@silver.com'    } },
  { first_name: 'Jack',  last_name: 'Gold',   contact: { email: 'j@gold.com'      } },
  { first_name: 'Tom',   last_name: 'Meyers', contact: { email: 'meyers@mail.com' } }
]
teachers = Person.create! teachers
teachers.each do |person|
  teacher = School.add_teacher! person
  [1, 2, 3].sample.times do
    start_date = [1, 2].sample.year.ago
    Course.create!(
      name:       "SP #{start_date.year}",
      teacher:    teacher,
      start_date: start_date,
      end_date:   start_date + [2, 3, 4].sample.years
    )
  end
end
