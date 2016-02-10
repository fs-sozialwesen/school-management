class TimeTable < ActiveRecord::Base
  belongs_to :course, required: true

  has_many :lessons, inverse_of: :time_table

  accepts_nested_attributes_for :lessons

  validates :start_date, presence: true
  before_save :make_start_date_a_monday

  def name
  end

  def end_date
    start_date + 4
  end

  private

  def make_start_date_a_monday
    self.start_date = start_date.beginning_of_week
  end
end
