
response.headers['Content-Disposition'] = 'attachment; filename="bewerber.csv"'

CSV.generate do |csv|
  csv << %w(Status Eingangsdatum Vorname Nachname KLT Eingeladen Rueckmeldung ErgebnisKLT)
  @candidates.each do |candidate|
    interview = candidate.interview
    school_graduate     = candidate.school_graduate.graduate
    school_graduate     = "(#{school_graduate})" unless candidate.school_graduate.complete?
    profession_graduate = candidate.profession_graduate.graduate
    profession_graduate = "(#{profession_graduate})" unless candidate.profession_graduate.complete?
    date                = candidate.date.present? ? l(candidate.date, format: :short) : ''
    interview_date      = interview.date.present? ? l(interview.date, format: :short) : ''
    csv << [
      human_status_name(candidate.status),
      date,
      candidate.person.first_name,
      candidate.person.last_name,
      interview_date,
      (interview.invited ? 'ja' : 'nein'),
      human_answer_name(interview.answer),
      human_result_name(interview.result),
    ]
  end
end
