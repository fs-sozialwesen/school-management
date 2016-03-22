module PeopleHelper
  def index_path_for(person)
    return managers_people_path if person.manager?
    return teachers_people_path if person.teacher?
    return students_people_path if person.student?
    return mentors_people_path if person.mentor?
    # raise 'error'
  end
end
