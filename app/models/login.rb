class Login < ActiveRecord::Base

  belongs_to :person, inverse_of: :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_paper_trail

  def display_name
    email
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
