FactoryGirl.define do

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
