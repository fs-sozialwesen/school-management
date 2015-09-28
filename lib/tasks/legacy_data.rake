namespace :legacy_data do

  desc 'deletes all data in the database'
  task :clear => %w(environment) do

    Student.delete_all
    Course.delete_all
    Teacher.delete_all
    EducationSubject.delete_all

  end

  desc 'loads data from old system into the database'
  task :load => %w(environment) do

    # Importer.new(EducationSubject, %i(id name short_name)).run
    #
    # Importer.new(Teacher, %i(id email first_name last_name)).run
    #
    # Importer.new(Course, %i(id name education_subject_id teacher_id start_date end_date)).run

    Importer.new(Carrier, %i(id name street zip city email homepage phone fax)).run
  end
end
