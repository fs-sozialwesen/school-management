FactoryGirl.define do
  factory :contact do
    person 'John Meier'
    email
    phone
    fax
    mobile
    homepage 'http://example.com'
  end
end
