FactoryGirl.define do

  sequence :date_of_birth do
    year  = Date.today.year - [16, 17, 18, 19].sample
    month = (1..12).to_a.sample
    day   = (1..28).to_a.sample
    Date.new year, month, day
  end

  factory :student do
    first_name
    last_name
    email { "#{first_name}.#{last_name}@#{EMAIL_HOSTS.sample}".downcase }
    phone
    date_of_birth
    year { (2012..2015).to_a.sample }
    city
    street
    zip
    place_of_birth { CITYS.sample }
  end

end
