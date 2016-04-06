FactoryGirl.define do
  factory :institution do
    name { "Institution #{(rand * 1_000).to_i}" }
    organisation
    address FactoryGirl.build :address
    contact FactoryGirl.build :contact
    housing { Housing.new provided: [true, false].sample, costs: "#{(7..13).to_a.sample} EUR" }
    applying do
      Applying.new by_phone: [true, false].sample,
        by_mail: [true, false].sample,
        by_email: [true, false].sample,
        documents: 'the usual ones'
    end
    # description 'MyText'
    # comments 'MyText'
  end
end
