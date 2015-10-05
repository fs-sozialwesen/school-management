namespace :legacy_data do

  desc 'deletes all data in the database'
  task :clear => %w(environment) do

    Carrier.delete_all
    CourseMembership.delete_all
    Student.delete_all
    Course.delete_all
    Teacher.delete_all
    EducationSubject.delete_all
    Carrier.delete_all

  end

  desc 'loads the csv files into to the legacy_data table'
  task :load => %w(environment) do
    LegacyDatum.delete_all

    Dir[Rails.root.join 'db/seeds/csv/*.csv'].each do |csv_file|
      table_name = File.basename(csv_file).sub('.csv', '')
      puts "Import #{table_name}"
      CSV.read(csv_file, headers: true).each do |row|
        LegacyDatum.create! old_table: table_name, old_id: row['id'], data: row.to_hash
      end
    end
  end

  desc 'imports data from old system into the database'
  task :import => %w(environment) do

    Importer.import_all

  end
end
