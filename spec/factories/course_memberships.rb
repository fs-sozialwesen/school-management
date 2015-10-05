FactoryGirl.define do
  factory :course_membership do
    student nil
    course nil
    start_date "2015-09-28"
    end_date "2015-09-28"
    active false
  end

end
