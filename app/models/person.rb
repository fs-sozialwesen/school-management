# class Person
class Person < ActiveRecord::Base
  ROLES = %w(admin manager teacher mentor).freeze
  AS_ROLES = ROLES.map { |role| "as_#{role}".to_sym }.freeze

  acts_as_addressable
  acts_as_contactable

  # has_one :login, inverse_of: :person, dependent: :destroy
  has_one :login, as: :user, dependent: :destroy
  # has_many :roles, dependent: :destroy, inverse_of: :person
  # has_many :contracts, as: :first_party

  validates :first_name, :last_name, presence: true

  has_one :as_admin,     class_name: 'Admin'
  has_one :as_manager,   class_name: 'Manager', dependent: :destroy
  has_one :as_teacher,   class_name: 'Teacher', dependent: :destroy
  has_one :as_mentor,    class_name: 'Mentor', dependent: :destroy

  scope :admins,   -> { joins(:as_admin).    includes(:as_admin) }
  scope :managers, -> { joins(:as_manager).  includes(:as_manager) }
  scope :teachers, -> { joins(:as_teacher).  includes(:as_teacher) }
  # scope :mentors,  -> { joins(:as_mentor).   includes(:as_mentor) }
  scope :active,   -> { where.not archived: true }
  scope :archived, -> { where archived: true }

  include PgSearch
  multisearchable against: [:first_name, :last_name, :address, :contact]

  has_paper_trail

  ROLES.each { |role| define_method("#{role}?") { as(role).present? } }
  AS_ROLES.each { |role| accepts_nested_attributes_for role }

  def as(role)
    send "as_#{role}"
  end

  def roles
    AS_ROLES.map { |role| send role }.compact
  end

  def student?
    false
  end

  def name
    "#{first_name} #{last_name}"
  end

end
