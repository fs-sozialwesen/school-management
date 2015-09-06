FactoryGirl.define do
  factory :teacher do
    first_name
    last_name
    email { "#{first_name}.#{last_name}@#{EMAIL_HOSTS.sample}".downcase }
    city
    street
    zip
  end

end
