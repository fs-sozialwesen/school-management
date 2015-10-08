FactoryGirl.define do
  factory :time_block do
    start_hour 9
    start_minute 15
    end_hour 10
    end_minute 45
    position 1
    active true
  end

end
