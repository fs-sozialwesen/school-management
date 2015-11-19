# require_relative 'role/admins'

FactoryGirl.define do
  factory :person do
    first_name 'MyString'
    last_name 'MyString'
    gender 'MyString'
    date_of_birth '2015-11-06'
    place_of_birth 'MyString'

    login

    trait :admin do
      association :as_admin, factory: :role_admin
    end

    factory :student do
      association :as_student, factory: :role_student
    end

  end

end
