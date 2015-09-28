class Course < ActiveRecord::Base

  belongs_to :teacher
  belongs_to :education_subject

  # has_one :leadership
  # has_one :course_teacher, through: :leadership

  # has_many :course_memberships
  # has_many :students, through: :course_memberships

  has_paper_trail


  validates :name, :education_subject, :start_date, :end_date, presence: true

  # def students_count
  #   students.count
  # end

  rails_admin do
    # configure :students do
    #   pretty_value do
    #     course = bindings[:object]
    #     %{<table>
    #       #{course.students.inspect}
    #     </table>}.html_safe
    #   end
    #   # children_fields [:name, :phone, :logo] # will be used for searching/filtering, first field will be used for sorting
    #   read_only true # won't be editable in forms (alternatively, hide it in edit section)
    # end

    list do
      field :name
      field :education_subject
      field :teacher
      # field(:students_count) { label { I18n.t('attributes.students') } }
      field(:start_date) { formatted_value { value.year } }
      field(:end_date) { formatted_value { value.year } }
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end

    show do
      field :name
      # field(:students_count) { label { I18n.t('attributes.students') } }

      # field :students
      # exclude_fields :first_name, :last_name
      # field(:email, :email)
      # field(:address, :address)
      # include_all_fields
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end
  end
end
