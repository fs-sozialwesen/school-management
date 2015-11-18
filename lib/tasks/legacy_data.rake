namespace :legacy_data do

  desc 'deletes all data in the database'
  task :clear => %w(environment) do

    [
      # Login,
      InternshipPosition,
      CourseMembership,
      Course,
      Contract,
      Role,
      Organisation,
      Person,
      EducationSubject,
    ].each { |model| model.destroy_all }

  end

  desc 'loads the csv files into to the legacy_data table'
  task :load => %w(environment) do

    Importer.load_from_csv

  end

  desc 'imports data from old system into the database'
  task :import => %w(environment) do

    Importer.import_all

  end
end
