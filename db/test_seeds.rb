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

EducationSubject.create!(school: school1, name: 'Gardening',  short_name: 'GA')
EducationSubject.create!(school: school2, name: 'Plumbing',   short_name: 'PL')
EducationSubject.create!(school: school2, name: 'Touristing', short_name: 'TO')

# John is manager and teacher on School1
john = { first_name: 'John', last_name: 'Maker', contact: { email: 'john@bak.er' } }
Person.create!(john) do |person|
  person.create_as_manager! organisation: school1
  person.create_as_teacher! organisation: school1
  person.generate_login!((person.first_name + person.last_name).downcase)
end

# Sofia is manager on School1
sofia = { first_name: 'Sofia', last_name: 'Gentle', contact: { email: 'sofia@gent.le' } }
Person.create!(sofia) do |person|
  person.create_as_manager! organisation: school1
  person.generate_login!((person.first_name + person.last_name).downcase)
end

# # Fred is teacher on School1
# fred = { first_name: 'Fred', last_name: 'Mecky', contact: {email: 'meck@mail.com'} }
# Person.create!(fred) do |person|
#   person.create_as_teacher! organisation: school1
#   person.generate_login! (person.first_name + person.last_name).downcase
# end

[
  { first_name: 'Maria', last_name: 'Silver', contact: { email: 'm@silver.com' } },
  { first_name: 'Jack',  last_name: 'Gold',   contact: { email: 'j@gold.com' } },
  { first_name: 'Tom',   last_name: 'Meyers', contact: { email: 'meyers@mail.com' } }
].map do |teach|
  Person.create!(teach) do |person|
    teacher           = person.create_as_teacher! organisation: [school1, school2].sample
    start_date        = [1, 2, 3].sample.year.ago
    education_subject = teacher.organisation.education_subjects.last
    [1, 2, 3].sample.times do
      Course.create!(
        name:              [education_subject.short_name, start_date.year].join(' '),
        education_subject: education_subject,
        teacher:           teacher,
        start_date:        start_date,
        end_date:          start_date + [2, 3].sample.years
      )
    end
  end
end
