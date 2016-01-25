FactoryGirl.define do
  factory :contact do
    person
    email
    phone
    fax
    mobile
    homepage 'http://example.com'
  end
end
