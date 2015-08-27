class Course < ActiveRecord::Base

  belongs_to :teacher

  has_many :students


  validates :name, :education_subject, :start_date, :end_date, presence: true

end
