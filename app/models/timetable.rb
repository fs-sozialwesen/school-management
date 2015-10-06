class Timetable < ActiveRecord::Base
  belongs_to :course

  validates :course, :start_date, :end_date, presence: true
  validate :start_date_is_a_monday
  validate :end_date_is_a_friday
  validate :start_and_end_are_in_same_week

  def name
    "#{course.name} (#{start_date})" if course
  end

  rails_admin do
    navigation_label 'Stundenplan'
  end

  private

  def start_date_is_a_monday
    errors.add(:start_date, "muss ein Montag sein") unless start_date.wday == 1
  end

  def end_date_is_a_friday
    errors.add(:end_date, "muss ein Freitag sein") unless end_date.wday == 5
  end

  def start_and_end_are_in_same_week
    errors.add(:end_date, "muss in der gleichen Woche liegen") unless start_date.cweek == end_date.cweek
  end

end
