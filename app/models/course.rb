class Course < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :education_subject

  has_many :students


  validates :name, :education_subject, :start_date, :end_date, presence: true

  def students_count
    students.count
  end

  rails_admin do

    list do
      field :name
      field :education_subject
      field :teacher
      field(:students_count) { label { I18n.t('attributes.students') } }
      field(:start_date) { formatted_value { value.year } }
      field(:end_date) { formatted_value { value.year } }
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end

    # show do
    #   field :name
    #   exclude_fields :first_name, :last_name
    #   field(:email, :email)
    #   field(:address, :address)
    #   include_all_fields
    #   field(:created_at) { date_format :short }
    #   field(:updated_at) { date_format :short }
    # end
  end
end
