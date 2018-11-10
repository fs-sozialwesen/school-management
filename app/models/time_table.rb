class TimeTable < ActiveRecord::Base
  belongs_to :course, inverse_of: :time_tables, required: true, counter_cache: true

  has_many :lessons, inverse_of: :time_table, dependent: :delete_all

  scope :active, -> { where.not activated_at: nil }

  accepts_nested_attributes_for :lessons

  validates :start_date, presence: true, uniqueness: { scope: [:course_id] }
  before_validation :make_start_date_a_monday, on: :create

  def name
    st = I18n.l(start_date, format: :wday_short)
    en = I18n.l(end_date, format: :wday_short)
    year = start_date.year
    "#{st} - #{en} #{year}"
  end

  def end_date
    start_date + 4
  end

  def active?
    !!activated_at
  end

  def toggle_active!
    update! activated_at: (active? ? nil : Date.current)
  end

  private

  def make_start_date_a_monday
    self.start_date = start_date.beginning_of_week if start_date.present?
  end
end
