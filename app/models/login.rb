class Login < ActiveRecord::Base

  belongs_to :person, inverse_of: :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  def display_name
    email
  end
  
end
