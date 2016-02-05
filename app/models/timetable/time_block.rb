class Timetable::TimeBlock < ActiveRecord::Base

  has_many :lessons

  validates :start_time, :end_time, presence: true
  
  def name
    "#{formatted_start_time} - #{formatted_end_time}"
  end

  def formatted_start_time
    start_time.to_formatted_s(:time) if start_time
  end

  def formatted_end_time
    end_time.to_formatted_s(:time) if end_time
  end

end
