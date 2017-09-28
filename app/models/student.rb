class Student < ActiveRecord::Base
  has_one :login, as: :user, dependent: :destroy

  belongs_to :course, inverse_of: :students, counter_cache: true
  has_many :internships, inverse_of: :student

  has_many :course_memberships, dependent: :delete_all
  has_many :courses, through: :course_memberships
  has_one :course_membership, -> { where active: true }
  # has_one :course, through: :course_membership
  # has_one :education_subject, through: :course
  # has_one :school, through: :education_subject
  has_one :candidate, inverse_of: :student

  validates :first_name, :last_name, presence: true

  accepts_nested_attributes_for :person

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
