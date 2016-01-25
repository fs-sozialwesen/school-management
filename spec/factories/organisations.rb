FactoryGirl.define do
  factory :organisation do
    name { "Organisation #{(rand * 1_000).to_i}" }
    address FactoryGirl.build :address
    contact FactoryGirl.build :contact

  end
end
