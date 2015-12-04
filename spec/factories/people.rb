# require_relative 'role/admins'

FactoryGirl.define do

  sequence(:first_name) { %w(John Mary Thomas).sample }
  sequence(:last_name)  { %w(Smith Miller Terry McArthur).sample }
  sequence(:gender)     { %w(f m).sample }

  factory :person do
    first_name
    last_name
    gender
    date_of_birth { (16..40).to_a.sample.years.ago }
    # place_of_birth ''

    association :login, password: '12341234', password_confirmation: '12341234'

    trait :admin do
      association :as_admin, factory: :role_admin
    end

    trait :student do
      association :as_student, factory: :role_student
    end

  end

end
