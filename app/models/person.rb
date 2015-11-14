class Person < ActiveRecord::Base

  has_one :login, inverse_of: :person, dependent: :destroy
  # has_one :contact, as: :contactable#, dependent: :destroy
  has_many :roles, dependent: :destroy

  has_many :contracts, as: :first_party

  validates :first_name, :last_name, presence: true

  # accepts_nested_attributes_for :contact

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
    as_role = "as_#{role}".to_sym
    define_method "#{role}?" do
      send(as_role).present? && send(as_role).persisted?
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def role_names
    roles.all.map do |role|
      role.class.model_name.human
    end.join(', ')
  end


  rails_admin do
    # hide
    # navigation_label I18n.t(:basic_data)

    list do
      field :first_name
      field :last_name
      field :city
      field :email
      field :role_names
      field :roles
    end
  end


end
