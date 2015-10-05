# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call delete_all: true
# puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

unless Rails.env.production?
  # Student.delete_all

  # generate 6 to 32 students for each class
  # Course.all.each do |course|
  #   students_count = (6..32).to_a.sample
  #   FactoryGirl.create_list :student,
  #     students_count,
  #     course: course,
  #     year: course.start_date.year,
  #     education_subject: course.education_subject
  # end
end
