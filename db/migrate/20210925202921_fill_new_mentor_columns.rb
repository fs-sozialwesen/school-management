class FillNewMentorColumns < ActiveRecord::Migration
  def up
    Mentor.includes(:person).each do |mentor|
      person = mentor.person
      mentor.first_name = person.first_name
      mentor.last_name  = person.last_name
      mentor.address    = person.address
      mentor.contact    = person.contact
      mentor.gender     = person.gender
      mentor.archived   = person.archived
      mentor.save
    end
  end

  def down
  end
end
