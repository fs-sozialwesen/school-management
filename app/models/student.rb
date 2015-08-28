class Student < ActiveRecord::Base

  belongs_to :course
  belongs_to :education_subject

  validates :first_name, :last_name, :email, :street, :zip, :city, :phone, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  rails_admin do

    list do
      field :first_name
      field :last_name
      field :year
      field(:email, :email)
      include_fields :education_subject, :course, :city
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end

  end
end
