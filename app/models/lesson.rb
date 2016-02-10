class Lesson < ActiveRecord::Base
  belongs_to :time_table, inverse_of: :lessons
  belongs_to :teacher
  belongs_to :subject
  belongs_to :room
  belongs_to :time_block

  def empty?
    teacher_id.blank? or subject_id.blank?
  end

  def teacher_name
    return '' unless teacher.present?
    [teacher.first_name[0...1], teacher.last_name].join '. '
  end

end
