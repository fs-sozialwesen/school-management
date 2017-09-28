namespace :login do
  desc 'recreate all logins which where not logged in yet'
  task :renew_not_logged_in_yet => %w(environment) do
    students = Student.joins(:login, :course)
      .where('logins.last_sign_in_at' => nil, 'courses.id' => Course.active, 'students.active' => true)


    puts "#{students.count} active students not logged in yet"

    students.all.each do |student|
      student.login.destroy
      LoginGenerator.(student, eamil: student.contact.email)
    end

    puts "#{students.count} active students not logged in yet"
  end
end
