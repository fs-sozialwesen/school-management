class Person < ActiveRecord::Base

  ROLES = %w[admin manager teacher student mentor].freeze
  AS_ROLES = ROLES.map { |role| "as_#{role}".to_sym }.freeze

  acts_as_addressable
  acts_as_contactable

  has_one :login, inverse_of: :person, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :contracts, as: :first_party

  validates :first_name, :last_name, presence: true
  # validate :student_has_no_other_roles

  has_one :as_admin,   class_name: 'Role::Admin'
  has_one :as_manager, class_name: 'Role::Manager'
  has_one :as_teacher, class_name: 'Role::Teacher'
  has_one :as_student, class_name: 'Role::Student'
  has_one :as_mentor,  class_name: 'Role::Mentor'

  scope :admins,   -> { joins(:as_admin)}
  scope :managers, -> { joins(:as_manager)}
  scope :teachers, -> { joins(:as_teacher)}
  scope :students, -> { joins(:as_student)}
  scope :mentors,  -> { joins(:as_mentor)}

  ROLES.each { |role| define_method("#{role}?") { as(role).present? && as(role).persisted? } }
  AS_ROLES.each { |role| accepts_nested_attributes_for role }

  def as(role)
    send "as_#{role}"
  end

  def name
    "#{first_name} #{last_name}"
  end

  def generate_login!(pw)
    create_login do |login|
      login.email    = contact.email
      login.password = login.password_confirmation = pw
      login.confirm
    end
  end

  rails_admin do
    # hide
    # label I18n.t(:people_index)

    Address. attribute_set.each { |attr| configure(attr.name) { group :address } }
    # Contact. attribute_set.each { |attr| configure(attr.name) { group :contact } }

    configure(:email)  { group :contact }
    configure(:mobile) { group :contact }
    configure(:phone)  { group :contact }
    configure(:fax)    { group :contact }

    configure(:roles)      { group :roles }
    AS_ROLES.each { |role| configure(role) { group :roles } }

    list do
      scopes [:students, :teachers, :managers, :mentors, :admins, nil]

      field :first_name, :self_link
      field :last_name, :self_link
      field :city
      field :email, :email
      field :phone
      # field :roles
    end
    show do
      fields :first_name, :last_name, :gender, :date_of_birth, :place_of_birth
      fields :street, :zip, :city
      fields :email, :mobile, :phone, :fax
      fields :roles, :as_admin, :as_manager, :as_teacher, :as_mentor, :as_student
    end
    edit do
      fields :first_name, :last_name, :gender, :date_of_birth, :place_of_birth
      fields :street, :zip, :city
      fields :email, :mobile, :phone, :fax
      # field :roles
      fields :as_admin, :as_manager, :as_teacher, :as_mentor, :as_student
    end
  end

  private

  def student_has_no_other_roles
    errors.add :base, I18n.t(:student_cant_have_other_roles) if student? && roles.count > 0
  end

end
