class Person < ActiveRecord::Base

  belongs_to :user, inverse_of: :person, dependent: :delete

  validates :first_name, :last_name, :email, presence: true

  def create_login!
    create_user do |user|
      user.email = email
      user.password = user.password_confirmation = (last_name + first_name).downcase
      user.confirm!
      user.admin!   if self.is_a? Employee
      user.teacher! if self.is_a? Teacher
      user.student! if self.is_a? Student
    end
  end

  def name
    "#{first_name} #{last_name}"
  end


  rails_admin do
    hide
    # navigation_label 'Stammdaten'

  end

end
