
response.headers['Content-Disposition'] = 'attachment; filename="bewerber.csv"'

CSV.generate do |csv|
  csv << %w(Status Eingangsdatum Vorname Nachname Jahr Fachrichtung Schulausb. Berufsausb.)
  @candidates.each do |candidate|
    school_graduate     = candidate.school_graduate.graduate
    school_graduate     = "(#{school_graduate})" unless candidate.options.school_graduate?
    profession_graduate = candidate.profession_graduate.graduate
    profession_graduate = "(#{profession_graduate})" unless candidate.options.profession_graduate?
    date                = candidate.options.date.present? ? l(candidate.options.date, format: :short) : ''
    csv << [
      candidate.aasm.human_state,
      date,
      candidate.person.first_name,
      candidate.person.last_name,
      candidate.year,
      candidate.education_subject,
      school_graduate,
      profession_graduate,
    ]
  end
end
