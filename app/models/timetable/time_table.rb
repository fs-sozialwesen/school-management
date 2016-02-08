class Timetable::TimeTable < ActiveRecord::Base
  belongs_to :course, required: true

  validates :start_date, presence: true
  before_save :make_start_date_a_monday

  def name
  end

  private

  def make_start_date_a_monday
    self.start_date = start_date.beginning_of_week
  end

end
