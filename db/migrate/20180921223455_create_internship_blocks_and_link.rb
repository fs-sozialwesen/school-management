class CreateInternshipBlocksAndLink < ActiveRecord::Migration

  def up
    courses_blocks = Internship.joins(student: :course).where.not('courses.name' => 'Dropouts')
      .group("courses.name", 'internships.block').count.keys
      .group_by(&:first).map {|course, interns| [course, interns.map(&:last)] }.to_h

    new_blocks = []
    courses_blocks.each do |course, blocks|
      # course = Course.find_by name: course
      blocks.each do |block|
        year = course.first(6)
        internships = Internship.joins(student: :course).where('courses.name' => course, 'internships.block' => block)
        start_date = internships.group('internships.start_date').count.to_a.map(&:reverse).sort.last.last
        end_date = internships.group('internships.end_date').count.to_a.map(&:reverse).sort.last.last
        new_blocks << { name: "#{year}#{block}", course_year: year.last(4), start_date: start_date, end_date: end_date }
      end
    end
    InternshipBlock.create! new_blocks.uniq

    Internship.includes(student: :course).all.each do |internship|
      name = internship.student.course.name.first(6)
      name += internship.block
      block = InternshipBlock.find_by name: name
      next unless block
      internship.update internship_block_id: block.id
    end

  end

  def down
    Internship.update_all internship_block_id: nil
    InternshipBlock.delete_all
  end

end
