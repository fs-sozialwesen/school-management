class CreateRandomStudentsService

  FIRST_NAMES = %w(Sabine Carola Marianne Thomas Mike Claudia Klaus Conrad Max Johannes Florian
                    Anne Björn Franziska Sarah Tobias Yvonne)
  LAST_NAMES = %w(Meier Müller Schulze Schmidt Schmitt Meyer Varoufakis Steinbrecher Landsknecht Albrecht)
  EMAIL_HOSTS = %w(gmx.net web.de yahoo.com gmail.com)
  CITYS = %w(Aschersleben Ballenstedt Quedlinburg Halberstadt Hettstedt Wernigerode)
  def call(delete_all: false)
    Student.delete_all if delete_all
    50.times { create_random_student }
  end

  def create_random_student
    first_name = FIRST_NAMES.sample
    last_name = LAST_NAMES.sample
    Student.create!(
      first_name: first_name,
      last_name: last_name,
      email: random_email_for(first_name, last_name),
      address: random_address,
      phone: rand.to_s.sub('.', '')[0..(7..11).to_a.sample],
      year: [2013, 2014, 2015].sample,
      education_subject: education_subjects.sample,
      course: courses.sample
    )
  end

  def random_email_for(first_name, last_name)
    "#{first_name.downcase}.#{last_name.downcase}@#{EMAIL_HOSTS.sample}"
  end

  def random_address
    "Lange Straße 78\n12345 #{CITYS.sample}"
  end

  def education_subjects
    @education_subjects ||= EducationSubject.all.to_a
  end

  def courses
    @courses ||= Course.all.to_a
  end
end
