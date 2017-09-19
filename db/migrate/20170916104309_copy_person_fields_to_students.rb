class CopyPersonFieldsToStudents < ActiveRecord::Migration
  ATTRS = %w(first_name last_name gender date_of_birth place_of_birth address contact)

  def up
    say_with_time 'assign person attrs to students' do
      ActiveRecord::Base.connection.execute <<-SQL
        UPDATE students AS s
        SET #{ATTRS.map {|a| "#{a} = p.#{a}" }.join(', ')}
        FROM people AS p
        WHERE s.person_id = p.id
      SQL
    end
  end

  def down
    say_with_time 'remove person attrs to students' do
      ActiveRecord::Base.connection.execute <<-SQL
        UPDATE students SET #{ATTRS.map {|a| "#{a} = null" }.join(', ')}
      SQL
    end
  end
end
