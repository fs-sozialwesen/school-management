class Student < Person

  # belongs_to :education_subject

  has_many :course_memberships, dependent: :delete_all
  has_many :courses, through: :course_memberships
  has_one :course_membership, -> { where active: true }
  has_one :course, through: :course_membership
  has_one :education_subject, through: :course

  has_one :course_teacher, through: :course, source: :teacher

  has_many :internships, inverse_of: :student

  Course.course_scopes.each do |course_sym, course_name|
    scope course_sym, -> do
      includes(:course_memberships, :courses).
        where(course_memberships: {active: true}).
        where(courses: {name: course_name})
    end
  end


  validates :street, presence: true
  validates :zip,    presence: true
  validates :city,   presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def year
    course.start_date.year if course.present?
  end

  rails_admin do
      parent Course

    list do
      scopes [nil] + Course.course_scopes.keys.sort
      sort_by :last_name
      field :first_name, :self_link
      field :last_name, :self_link
      # field :course
      # field :education_subject
      # field(:year) do
      #   column_width 30
      # end
      field(:email, :email)
      field :city
    end

    show do
      group(:default) do
        field :first_name
        field :last_name
        field :email, :email
        field :date_of_birth
        field :place_of_birth
      end
      group(:address) do
        label 'Adresse'
        field :street
        field :zip
        field :city
      end
      group(:course) do
        label 'Klasse'
        field :course
        field :course_teacher
        field :education_subject
        field :year
      end

    end

    edit do
      exclude_fields :course_memberships, :courses, :course_membership, :course, :internships, :type
    end

  end
end
