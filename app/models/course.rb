# class Course
class Course < ActiveRecord::Base
  belongs_to :teacher, required: true, inverse_of: :courses
  # belongs_to :education_subject, required: true, inverse_of: :courses

  # has_one :leadership
  # has_one :course_teacher, through: :leadership

  has_many :course_memberships
  has_many :active_course_memberships, -> { where active: true }, class_name: 'CourseMembership'
  has_many :students, inverse_of: :course #, through: :active_course_memberships
  # has_many :lessons, inverse_of: :course

  has_paper_trail

  scope :active,   -> { where('end_date > ?',  Date.current) }
  scope :inactive, -> { where('end_date <= ?', Date.current) }

  validates :name, :start_date, :end_date, presence: true

  def self.course_scopes
    active.all.each_with_object({}) do |course, hsh|
      hsh[course.underscore_name] = course.name
    end
  end

  def underscore_name
    name.downcase.tr(' ', '_').to_sym
  end

  def add_student!(student)
    course_memberships.find_or_create_by! student: student
    student.course = self
  end

  rails_admin do
    weight(-2)

    configure :students do
      pretty_value do
        course      = bindings[:object]
        url_options = { model_name: 'student', scope: course.underscore_name }
        url         = bindings[:view].rails_admin.index_path url_options
        bindings[:view].link_to "#{course.students.count} #{I18n.t('attributes.students')}", url
      end
      # children_fields [:first_name, :phone] # will be used for searching/filtering,
      # first field will be used for sorting
      # read_only true # won't be editable in forms (alternatively, hide it in edit section)
      group :students
    end

    list do
      scopes [:active, :inactive, nil]
      # sort_by :education_subject

      field :name, :self_link
      # fields :education_subject, :teacher, :students
      fields :teacher, :students
      field(:start_date) { formatted_value { "#{value.month}/#{value.year}" } }
      field(:end_date) { formatted_value { "#{value.month}/#{value.year}" } }
    end

    show do
      # fields :name, :education_subject, :teacher, :start_date, :end_date
      fields :name, :teacher, :start_date, :end_date
      field :students
    end

    edit do
      # fields :name, :education_subject, :teacher, :start_date, :end_date
      fields :name, :teacher, :start_date, :end_date
      field :students
    end
  end
end
