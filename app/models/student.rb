class Student < ActiveRecord::Base

  has_one :login, as: :user, dependent: :destroy

  belongs_to :course, inverse_of: :students, counter_cache: true
  has_many :internships, inverse_of: :student

  has_one :candidate, inverse_of: :student
  has_one :contract_termination, inverse_of: :student

  scope :active, -> { where active: true }
  scope :inactive, -> { where.not active: true }

  validates :first_name, :last_name, presence: true

  include PgSearch
  multisearchable against: %i[first_name last_name address contact]

  acts_as_addressable
  acts_as_contactable

  has_paper_trail

  def name
    [first_name, last_name].join ' '
  end

  def student?
    true
  end

  def manager?
    false
  end

  def teacher?
    false
  end

  def admin?
    false
  end

  def mentor?
    false
  end

end
