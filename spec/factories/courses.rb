FactoryGirl.define do
  factory :course do
    start_date { Date.new [2013, 2014, 2015].sample, 9, 1 }
    end_date { start_date + 3.years }
    name { education_subject.name[0..5] + start_date.year.to_s[2..3] }
  end

end
