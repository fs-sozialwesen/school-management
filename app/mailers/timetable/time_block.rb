class Timetable::TimeBlock < ActiveRecord::Base

  has_many :lessons

  validates :start_time, :end_time, :position, presence: true

  default_scope -> { order :position }

  scope :active,   -> { where active: true }
  scope :inactive, -> { where active: false }

  def name
    "#{start_time} - #{end_time}"
  end

  def start_time
    format_time start_hour, start_minute
  end

  def start_time=(new_time)
    time              = Time.parse new_time
    self.start_hour   = time.hour
    self.start_minute = time.min
    time
  end

  def end_time
    format_time end_hour, end_minute
  end

  def end_time=(new_time)
    time            = Time.parse new_time
    self.end_hour   = time.hour
    self.end_minute = time.min
    time
  end

  rails_admin do
    hide
    navigation_label I18n.t(:timetable)

    list do
      sort_by :position
      scopes [:active, :inactive, nil]
      field :position
      field :name
    end

    edit do
      field :start_time
      field :end_time
      field :position
      field :active
    end
  end

  private

  def format_time(hour, minute)
    Time.new.change(hour: hour, min: minute).strftime "%H:%M"
  end
end
