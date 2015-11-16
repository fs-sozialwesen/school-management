class Person < ActiveRecord::Base

  serialize :address, Address
  serialize :contact, Contact

  has_one :login, inverse_of: :person, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :contracts, as: :first_party

  validates :first_name, :last_name, presence: true
  validate :student_has_no_other_roles

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

  %w[admin manager teacher student mentor].each do |role|
    define_method("#{role}?") { as(role).present? && as(role).persisted? }
  end

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
      login.confirm!
    end
  end

  rails_admin do
    # hide
    # navigation_label I18n.t(:basic_data)

    list do
      field :first_name
      field :last_name
      # field :city
      # field :email
      field :roles
    end
  end

  private

  def student_has_no_other_roles
    errors.add :base, I18n.t(:student_cant_have_other_roles) if student? && roles.count > 0
  end

end
