class CreateInternshipBlocksAndLink < ActiveRecord::Migration

  def up
    courses_blocks = Internship.joins(student: :course).where.not('courses.name' => 'Dropouts')
      .group("courses.name", 'internships.block').count.keys
      .group_by(&:first).map {|course, interns| [course, interns.map(&:last)] }.to_h

    new_blocks = []
    courses_blocks.each do |course, blocks|
      blocks.each do |block|
        year = course.first(6)
        internships = Internship.joins(student: :course).where('courses.name' => course, 'internships.block' => block)
        start_date = internships.group('internships.start_date').count.to_a.map(&:reverse).sort.last.last
        end_date = internships.group('internships.end_date').count.to_a.map(&:reverse).sort.last.last
        new_blocks << { name: "#{year}#{block}", course_year: year.last(4), start_date: start_date, end_date: end_date }
      end
    end
    blocks = InternshipBlock.create! new_blocks.uniq
    say "#{blocks.count} internship blocks created"

    count = 0
    Internship.joins(student: :course).where.not('courses.name' => 'Dropouts').includes(student: :course).all.each do |internship|
      name = internship.student.course.name.first(6)
      # puts "name: '#{name}', block: '#{internship.block}'"
      name += internship.block || 'P1'
      block = InternshipBlock.find_by name: name
      next unless block
      count += 1 if internship.update(internship_block_id: block.id)
    end

    say "#{count} internships linked to blocks"
  end

  def down
    Internship.update_all internship_block_id: nil
    InternshipBlock.delete_all
  end

end
