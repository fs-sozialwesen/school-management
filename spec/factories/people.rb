FactoryGirl.define do

  first_names  = %w(Sabine Carola Marianne Thomas Mike Claudia Klaus Conrad Max Johannes Florian
                      Anne Björn Franziska Sarah Tobias Yvonne)
  last_names   = %w(Meier Müller Schulze Schmidt Schmitt Meyer Varoufakis Steinbrecher Landsknecht Albrecht)
  emails_hosts = %w(gmx.net web.de yahoo.com gmail.com)
  cities       = %w(Aschersleben Ballenstedt Quedlinburg Halberstadt Hettstedt Wernigerode)

  sequence(:first_name) { first_names.sample }
  sequence(:last_name) { last_names.sample }
  sequence(:city) { cities.sample }
  sequence(:street) { "Sehr Lange Str. #{(rand*180).to_i}" }
  sequence(:zip) { rand.to_s[2..6] }
  sequence(:email) { |n| "info_#{n}@#{emails_hosts.sample}" }
  sequence(:phone) { '0' + rand.to_s[2..(7..11).to_a.sample] }
  sequence(:mobile) { '0' + rand.to_s[2..(7..11).to_a.sample] }
  sequence :date_of_birth do
    year  = Date.today.year - [16, 17, 18, 19].sample
    month = (1..12).to_a.sample
    day   = (1..28).to_a.sample
    Date.new year, month, day
  end



  factory :person do
    first_name
    last_name
    email { "#{first_name}.#{last_name}@#{emails_hosts.sample}".downcase }
    phone
    mobile
    date_of_birth
    place_of_birth { cities.sample }

    city
    street
    zip

    gender 'm'

    factory :student, class: Student do
      # year { (2012..2015).to_a.sample }
    end

    factory :teacher, class: Teacher do

    end

  end

end
