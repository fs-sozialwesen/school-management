require 'csv'

response.headers['Content-Disposition'] = %Q(attachment; filename="klassen-#{Time.now}.csv")

CSV.generate(encoding: 'UTF-8', col_sep: ';', force_quotes: true) do |csv|
  csv << %w(Name Klassenlehrer Beginn Ende Archiv Auszubildende)
  @courses.each do |course|
    csv << [
      course.name,
      course.teacher.name,
      ldate(course.start_date),
      ldate(course.end_date),
      (course.active? ? 'nein' : 'ja'),
      course.students.count
    ]
  end
end
