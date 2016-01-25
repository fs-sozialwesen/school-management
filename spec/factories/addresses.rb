FactoryGirl.define do

  sequence(:street) { | n | [["Lange Str.", "Hauptstr."].sample, n].join(' ') }
  sequence(:zip) { rand.to_s[2..6] }
  sequence(:city) { %w(Hamburg Mailand Madrid Lommatzsch).sample }

  factory :address do
    street
    zip
    city
  end
end
