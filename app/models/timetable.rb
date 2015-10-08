class Timetable

  # has_lessons could be one of course, teacher, room
  def initialize(has_lessons, date_in_week = Date.today)
    raise 'first param must have a "lessons" association' unless has_lessons.respond_to? :lessons
    raise 'first param must be a Date' unless date_in_week.is_a? Date
    @has_lessons  = has_lessons
    @date_in_week = date_in_week
  end

  def monday
    @date_in_week - @date_in_week.wday + 1
  end

  def friday
    monday + 4
  end

  def time_blocks
    TimeBlock.order(:position).where id: time_block_ids
  end

  def time_block_ids
    lessons.pluck(:time_block_id).uniq
  end

  def lessons
    @has_lessons.lessons.where('date >= ?', monday).where('date <= ?', friday)
  end

end
