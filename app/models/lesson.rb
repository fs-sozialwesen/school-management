class Lesson < ActiveRecord::Base
  belongs_to :time_table, inverse_of: :lessons, required: true
  belongs_to :teacher, required: true
  belongs_to :subject, required: true
  belongs_to :room
  belongs_to :time_block, required: true

  validates :weekday, presence: true, uniqueness: { scope: %i(time_table_id time_block_id) }

  def empty?
    teacher_id.blank? or subject_id.blank?
  end

  def teacher_name
    return '' unless teacher.present?
    [teacher.first_name[0...1], teacher.last_name].join '. '
  end

end
