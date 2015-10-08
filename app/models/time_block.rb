class TimeBlock < ActiveRecord::Base

  has_many :lessons

  validates :start_hour, :start_minute, :end_hour, :end_minute, presence: true

  default_scope -> { order :position }

  def name
    "#{start_time} - #{end_time}"
  end

  def start_time
    "#{start_hour}:#{start_minute}"
  end

  def end_time
    "#{end_hour}:#{end_minute}"
  end

  rails_admin do
    navigation_label I18n.t(:timetable)

    list do
      sort_by :position
      field :name
      field :position
      field :active
    end
  end
end
