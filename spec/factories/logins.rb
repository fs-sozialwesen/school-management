# require_relative 'people'

FactoryGirl.define do

  sequence(:email) { |n| "person#{n}@example.com" }

  factory :login do
    confirmed_at Time.now
    email
    password 'please123'

    # person

    # trait :admin do
    #   # role 'admin'
    #   association :person #, FactoryGirl.build_stubbed(:person, :admin)
    # end

  end
end
