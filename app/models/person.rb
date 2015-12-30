# class Person
class Person < ActiveRecord::Base
  # ROLES = %w(admin manager teacher student mentor candidate).freeze
  ROLES = %w(admin manager teacher student candidate).freeze
  AS_ROLES = ROLES.map { |role| "as_#{role}".to_sym }.freeze

  acts_as_addressable
  acts_as_contactable

  has_one :login, inverse_of: :person, dependent: :destroy
  # has_many :roles, dependent: :destroy, inverse_of: :person
  # has_many :contracts, as: :first_party

  validates :first_name, :last_name, presence: true
  # validates :date_of_birth, :place_of_birth, presence: true#, if: :candidate?
  # validate :student_has_no_other_roles

  has_one :as_admin,     class_name: 'Admin'
  has_one :as_manager,   class_name: 'Manager'
  has_one :as_teacher,   class_name: 'Teacher'
  has_one :as_student,   class_name: 'Student'
  # has_one :as_mentor,    class_name: 'Mentor'
  has_one :as_candidate, class_name: 'Candidate'

  scope :admins,     -> { joins(:as_admin).    includes(:as_admin) }
  scope :managers,   -> { joins(:as_manager).  includes(:as_manager) }
  scope :teachers,   -> { joins(:as_teacher).  includes(:as_teacher) }
  scope :students,   -> { joins(:as_student).  includes(:as_student) }
  # scope :mentors,    -> { joins(:as_mentor).   includes(:as_mentor) }
  scope :candidates, -> { joins(:as_candidate).includes(:as_candidate) }

  ROLES.each { |role| define_method("#{role}?") { as(role).present? } }
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

    configure(:gender, :enum) { enum { { I18n.t(:female) => 'f', I18n.t(:male) => 'm' } } }

    Address.attribute_set.each { |attr| configure(attr.name) { group :address } }
    Contact.attribute_set.each do |attr|
      next if attr.name.in?(%i(person homepage))
      configure(attr.name) { group :contact }
    end

    configure(:roles)      { group :roles }
    AS_ROLES.each { |role| configure(role) { group :roles } }

    list do
      scopes [:students, :teachers, :managers, :candidates, nil]

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
      # fields :roles, :as_admin, :as_manager, :as_teacher, :as_mentor, :as_student
      fields :as_admin, :as_manager, :as_teacher, :as_student
    end
    edit do
      fields :first_name, :last_name, :gender, :date_of_birth, :place_of_birth
      fields :street, :zip, :city
      fields :email, :mobile, :phone, :fax
      # field :roles
      # fields :as_admin, :as_manager, :as_teacher, :as_mentor, :as_student, :as_candidate
      # fields :as_manager, :as_teacher, :as_student, :as_candidate
    end
    export do
      fields :first_name, :last_name, :gender, :date_of_birth, :place_of_birth
      fields :street, :zip, :city
      fields :email, :mobile, :phone, :fax
    end
  end

  # private
  #
  # def student_has_no_other_roles
  #   errors.add :base, I18n.t(:student_cant_have_other_roles) if student? && roles.count > 0
  # end
end
