FactoryGirl.define do
  factory :contact do
    person 'John Meier'
    email { generate :email }
    phone { generate :phone }
    fax { generate :fax }
    mobile { generate :mobile }
    homepage 'http://example.com'
  end
end
