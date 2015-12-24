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
  Contract,
  Role,
  Organisation,
  Person,
  EducationSubject
].each(&:destroy_all)

school_carrier = Organisation.create!(
  name:    'School carrier Orga',
  address: { street: 'Base street', zip: '12345', city: 'Mountain View' },
  contact: { phone: '555-5555', email: 'info@school-carrier.org' }
)
school1 = Organisation::School.create!(
  name:    'School for Something',
  carrier: school_carrier,
  address: { street: 'Parkway 33', zip: '32122', city: 'Sunnyvale' },
  contact: { email: 'sunnyvale@mail.com' }
)
school2 = Organisation::School.create!(
  name:    'Education School',
  carrier: school_carrier,
  address: { street: '1st Street', zip: '34567', city: 'Palo Alto' },
  contact: { email: 'edu@edu.edu' }
)

ga = school1.education_subjects.create!(name: 'Gardening',  short_name: 'GA')
pl = school2.education_subjects.create!(name: 'Plumbing',   short_name: 'PL')
to = school2.education_subjects.create!(name: 'Touristing', short_name: 'TO')

# John is manager and teacher on School1
john = Person.create!(first_name: 'John', last_name: 'Maker', contact: { email: 'john@bak.er' })
john.generate_login! 'johnmaker'
school1.add_manager! john
school1.add_teacher! john

# Sofia is manager on School1
{ first_name: 'Sofia', last_name: 'Gentle', contact: { email: 'sofia@gent.le' } }
sofia = Person.create!(first_name: 'Sofia', last_name: 'Gentle', contact: { email: 'sofia@gent.le' })
sofia.generate_login! 'sofiagentle'
school1.add_manager! sofia

# Other teachers
teachers = [
  { first_name: 'Maria', last_name: 'Silver', contact: { email: 'm@silver.com'    } },
  { first_name: 'Jack',  last_name: 'Gold',   contact: { email: 'j@gold.com'      } },
  { first_name: 'Tom',   last_name: 'Meyers', contact: { email: 'meyers@mail.com' } }
]
teachers = Person.create! teachers
teachers.each do |person|
  education_subject = [ga, pl, to].sample
  teacher           = education_subject.school.add_teacher! person
  [1, 2, 3].sample.times do
    start_date = [1, 2].sample.year.ago
    education_subject.courses.create!(
      name:       [education_subject.short_name, start_date.year].join(' '),
      teacher:    teacher,
      start_date: start_date,
      end_date:   start_date + [2, 3, 4].sample.years
    )
  end
end
