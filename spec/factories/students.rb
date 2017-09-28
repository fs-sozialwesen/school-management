FactoryGirl.define do
  factory :student do
    first_name
    last_name
    gender
    date_of_birth { (16..20).to_a.sample.years.ago }

    association :login, password: '12341234', password_confirmation: '12341234'
  end
end
