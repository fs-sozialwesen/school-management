class CopyPersonDataToCandidates < ActiveRecord::Migration
  def up
    Candidate.all.each do |candidate|
      person = Person.find_by id: candidate.person_id
      next unless person
      candidate.student_id     = person.as_student&.id
      candidate.first_name     = person.first_name
      candidate.last_name      = person.last_name
      candidate.gender         = person.gender
      candidate.date_of_birth  = person.date_of_birth
      candidate.place_of_birth = person.place_of_birth
      candidate.address        = person.address
      candidate.contact        = person.contact
      candidate.save
    end
  end

  def down
  end
end
