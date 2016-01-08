
response.headers['Content-Disposition'] = 'attachment; filename="bewerber.csv"'

CSV.generate do |csv|
  csv << %w(Status Eingangsdatum Vorname Nachname Jahr Schulausb. Berufsausb.)
  @candidates.each do |candidate|
    school_graduate     = candidate.school_graduate.graduate
    school_graduate     = "(#{school_graduate})" unless candidate.school_graduate.complete?
    profession_graduate = candidate.profession_graduate.graduate
    profession_graduate = "(#{profession_graduate})" unless candidate.profession_graduate.complete?
    date                = candidate.date.present? ? l(candidate.date, format: :short) : ''
    csv << [
      human_status_name(candidate.status),
      date,
      candidate.person.first_name,
      candidate.person.last_name,
      candidate.year,
      school_graduate,
      profession_graduate,
    ]
  end
end
