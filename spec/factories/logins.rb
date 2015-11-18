# require_relative 'people'

FactoryGirl.define do
  factory :login do
    confirmed_at Time.now
    # name "Test User"
    email 'test@example.com'
    password 'please123'

    person

    trait :admin do
      # role 'admin'
      association :person #, FactoryGirl.build_stubbed(:person, :admin)
    end

  end
end
