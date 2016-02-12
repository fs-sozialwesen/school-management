class TimeTable < ActiveRecord::Base
  belongs_to :course, inverse_of: :time_tables , required: true

  has_many :lessons, inverse_of: :time_table, dependent: :delete_all

  accepts_nested_attributes_for :lessons

  validates :start_date, presence: true, uniqueness: { scope: [:course_id] }
  before_validation :make_start_date_a_monday, on: :create

  def name
  end

  def end_date
    start_date + 4
  end

  private

  def make_start_date_a_monday
    self.start_date = start_date.beginning_of_week if start_date.present?
  end
end
