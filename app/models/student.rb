class Student < ActiveRecord::Base

  belongs_to :course
  belongs_to :education_subject
  has_many :internships, inverse_of: :student

  validates :first_name, :last_name, :email, :street, :zip, :city, :phone, presence: true

  def name
    "#{first_name} #{last_name}"
  end

  rails_admin do
      # navigation_label 'Praktikum'
      parent Course



    list do
      filters [:course, :education_subject]
      field :first_name
      field :last_name
      field(:year) { column_width 30 }
      field(:email, :email)
      include_fields :education_subject, :course, :city
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end

    # show do
    #   group(:default)
    #   group(:address)
    #   field(:name) { group :default }
    #   field(:city) { group :address }
    # end

  end
end
