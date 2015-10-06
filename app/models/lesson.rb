class Lesson < ActiveRecord::Base
  belongs_to :timetable
  belongs_to :teacher
  belongs_to :subject
  belongs_to :room

  validates :teacher, :timetable, :subject, :start_time, :end_time, presence: true

  validate :same_day
  validate :end_after_start

  rails_admin do
    parent Timetable
  end

  private

  def same_day
    errors.add(:end_time, 'muss am selben Tag sein') unless start_time.to_date == end_time.to_date
  end

  def end_after_start
    errors.add(:end_time, 'muss nach der Startzeit liegen') unless start_time < end_time
  end

end
