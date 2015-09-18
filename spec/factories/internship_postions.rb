FactoryGirl.define do
  factory :internship_position do
    name 'MyString'
    institution nil
    work_area 'MyString'
    description 'MyText'
    accommodation false
    kind_of_application 1
    year 2015
    application_documents 'MyString'
    contact_person 'MyString'
    comments 'MyText'
  end
end