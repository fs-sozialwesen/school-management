class Login < ActiveRecord::Base

  # belongs_to :person, inverse_of: :login
  belongs_to :user, polymorphic: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_paper_trail

  validates :password, presence: true, length: { minimum: 8 }, confirmation: true, on: :create

  attr_accessor :generate_password

  def generate_password?
    generate_password.in? ['1', true]
  end

  def confirmation_required?
    # !confirmed?
    # don't send confirmation mail
    false
  end

  # activate and deactivate logins
  def account_active?
    blocked_at.nil?
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    account_active? ? super : :locked
  end

  def toggle!
    update blocked_at: ( account_active? ? Time.current : nil )
  end

end
