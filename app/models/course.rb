class Course < ActiveRecord::Base

  belongs_to :teacher, required: true, class_name: 'Role::Teacher'
  belongs_to :education_subject, required: true

  # has_one :leadership
  # has_one :course_teacher, through: :leadership

  has_many :course_memberships
  has_many :active_course_memberships, -> { where active: true }, class_name: 'CourseMembership'
  has_many :students, through: :active_course_memberships
  # has_many :lessons, inverse_of: :course

  has_paper_trail

  scope :active,   -> { where('end_date > ?',  Date.today) }
  scope :inactive, -> { where('end_date <= ?', Date.today) }

  validates :name, :start_date, :end_date, presence: true

  def display_name
    "#{name} (#{education_subject.school.name})"
  end

  # def self.course_scopes
  #   active.all.each_with_object({}) do |course, hsh|
  #     hsh[course.underscore_name] = course.name
  #   end
  # end

  def underscore_name
    name.downcase.gsub(' ', '_').to_sym
  end

  rails_admin do

    weight -2

    configure :students do
        pretty_value do
          course      = bindings[:object]
          url_options = { model_name: 'student', scope: course.underscore_name }
          url         = bindings[:view].rails_admin.index_path url_options
          bindings[:view].link_to "#{course.students.count} #{I18n.t('attributes.students')}", url
        end
      # children_fields [:first_name, :phone] # will be used for searching/filtering, first field will be used for sorting
      # read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end

    list do
      scopes [:active, :inactive, nil]
      sort_by :education_subject

      field :name, :self_link
      field :education_subject
      field :teacher
      field :students
      field(:start_date) { formatted_value { "#{value.month}/#{value.year}" } }
      field(:end_date) { formatted_value { "#{value.month}/#{value.year}" } }
    end

    show do
      group(:default) do
        field :name
        field :education_subject
        field :teacher
        field :start_date
        field :end_date
      end

      group(:students) do
        field :students
      end


      # exclude_fields :course_memberships, :active_course_memberships
      # field(:students_count) { label { I18n.t('attributes.students') } }

      # field :students
      # exclude_fields :first_name, :last_name
      # field(:email, :email)
      # field(:address, :address)
      # include_all_fields
      # field(:created_at) { date_format :short }
      # field(:updated_at) { date_format :short }
    end

    edit do
      group(:default) do
        field :name
        field :education_subject
        field :teacher
        field :start_date
        field :end_date
      end

      group(:students) do
        field :students
      end
      # exclude_fields :course_memberships, :active_course_memberships
    end
  end
end
