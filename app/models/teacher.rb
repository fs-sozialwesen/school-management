class Teacher < ActiveRecord::Base
  belongs_to :person, validate: true, inverse_of: :as_teacher
  has_one :login, through: :person
  has_many :courses, ->{ order(:name) }, inverse_of: :teacher
  has_many :lessons, inverse_of: :teacher, dependent: :restrict_with_error

  scope :with_person, -> { joins(:person).order('people.last_name') }
  scope :active, -> { with_person.where(people: {archived: false}) }

  delegate :first_name, :last_name, :name, to: :person, allow_nil: true

  accepts_nested_attributes_for :person


  has_paper_trail

  def lessons_at(start_date)
    lessons.where(time_table: TimeTable.where(start_date: start_date))
  end

  def time_table_dates
    TimeTable.active.where(id: lessons.pluck(:time_table_id)).pluck(:start_date).uniq
  end
end
