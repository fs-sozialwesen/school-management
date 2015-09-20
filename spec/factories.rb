FactoryGirl.define do

  FIRST_NAMES = %w(Sabine Carola Marianne Thomas Mike Claudia Klaus Conrad Max Johannes Florian
                      Anne Björn Franziska Sarah Tobias Yvonne)
  LAST_NAMES = %w(Meier Müller Schulze Schmidt Schmitt Meyer Varoufakis Steinbrecher Landsknecht Albrecht)
  EMAIL_HOSTS = %w(gmx.net web.de yahoo.com gmail.com)
  CITYS = %w(Aschersleben Ballenstedt Quedlinburg Halberstadt Hettstedt Wernigerode)

  sequence(:first_name) { FIRST_NAMES.sample }
  sequence(:last_name) { LAST_NAMES.sample }
  sequence(:city) { CITYS.sample }
  sequence(:street) { "Sehr Lange Str. #{(rand*180).to_i}" }
  sequence(:zip) { rand.to_s[2..6] }
  sequence(:email) { |n| "info_#{n}@#{EMAIL_HOSTS.sample}" }
  sequence(:phone) { '0' + rand.to_s[2..(7..11).to_a.sample] }

end
