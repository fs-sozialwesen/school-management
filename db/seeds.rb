# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

unless Rails.env.production?
  EducationSubject.delete_all
  Course.delete_all
  Teacher.delete_all
  Student.delete_all

  education_subjects = ENV['EDUCATION_SUBJECTS'].split(',').map do |subject|
    EducationSubject.create! name: subject
  end
  teachers = FactoryGirl.create_list :teacher, 6
  years = [2013, 2014, 2015]
  education_subjects.each do |education_subject|
    years.each do |year|
      course = FactoryGirl.create(:course,
        teacher:           teachers.sample,
        education_subject: education_subject,
        start_date:        Date.new(year, 9, 1)
      )
      students_count = (12..20).to_a.sample
      FactoryGirl.create_list :student, students_count, course: course, year: year
    end
  end
end
