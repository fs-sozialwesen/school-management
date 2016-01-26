FactoryGirl.define do
  factory :contact do
    # sequence(:person) { 'John Mayer' }
    sequence(:email) { |n| "person#{n}@example.com" }
    sequence(:phone) { rand.to_s.sub('.', '')[0..7] }
    sequence(:fax) { rand.to_s.sub('.', '')[0..7] }
    sequence(:mobile) { rand.to_s.sub('.', '')[0..7] }

    person 'John Meier'
    # email { generate :email }
    # phone { generate :phone }
    # fax { generate :fax }
    # mobile { generate :mobile }
    homepage 'http://example.com'
  end
end
