class EducationSubject < ActiveRecord::Base

  validates :name, presence: true

  has_paper_trail

  def display_name
    short_name
  end

end
