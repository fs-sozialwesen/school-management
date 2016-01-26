FactoryGirl.define do

  factory :login do
    confirmed_at Time.now
    # email
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'please123'

    # person

    # trait :admin do
    #   # role 'admin'
    #   association :person #, FactoryGirl.build_stubbed(:person, :admin)
    # end

  end
end
