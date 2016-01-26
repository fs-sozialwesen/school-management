
response.headers['Content-Disposition'] = %Q(attachment; filename="#{@filename}.xml")

xml.instruct!
xml.bewerberliste do
  @candidates.each do |candidate|
    interview      = candidate.interview
    person         = candidate.person
    address        = person.address
    contact        = person.contact
    prof_grad      = candidate.profession_graduate
    prof_proved    = prof_grad.proved ? 'ja' : 'nein'
    prof_proved    = '-' if prof_grad.graduate.blank?
    intern_proved  = candidate.internships_proved ? 'ja' : 'nein'
    intern_proved  = '-' if candidate.internships.blank?

    xml.bewerber do
      xml.tag! :Status,        human_status_name(candidate.status)
      xml.tag! :Eingangsdatum, ldate(candidate.date)
      xml.tag! :Jahr,          candidate.year

      xml.tag! :Anrede,        ({ 'f' => 'Frau', 'm' => 'Herr' }[person.gender])
      xml.tag! :Vorname,       person.first_name
      xml.tag! :Nachname,      person.last_name
      xml.tag! :Geburtsdatum,  ldate(person.date_of_birth)
      xml.tag! :Geburtsort,    person.place_of_birth

      xml.tag! :Strasse,       address.street
      xml.tag! :PLZ,           address.zip
      xml.tag! :Ort,           address.city

      xml.tag! :Email,         contact.email
      xml.tag! :Telefon,       contact.phone
      xml.tag! :Mobil,         contact.mobile

      xml.tag! :Schulausbildung,     candidate.school_graduate.graduate
      xml.tag! :Schul_bestaetigt,    (candidate.school_graduate.proved ? 'ja' : 'nein')
      xml.tag! :Berufsausbildung,    prof_grad.graduate
      xml.tag! :Beruf_bestaetigt,    prof_proved
      xml.tag! :Sonstiges,           prof_grad.comments
      xml.tag! :Praktika,            candidate.internships.to_s.gsub(/\n/, ' ').gsub(/\r/, ' ')
      xml.tag! :Prak_bestaetigt,     intern_proved
      xml.tag! :Fuehrungszeugnis,    (candidate.police_certificate ? 'ja' : 'nein')

      xml.tag! :KLT,                 ldate(interview.date)
      xml.tag! :Eingeladen,          (interview.invited ? 'ja' : 'nein')
      xml.tag! :Rueckmeldung,        human_answer_name(interview.answer)
      xml.tag! :ErgebnisKLT,         human_result_name(interview.result)

      xml.tag! :AusbVertr_gesendet,  ldate(candidate.education_contract_sent)
      xml.tag! :AusbVertr_zurueck,   ldate(candidate.education_contract_received)
      xml.tag! :PraktVertr_gesendet, ldate(candidate.internship_contract_sent)
      xml.tag! :PraktVertr_zurueck,  ldate(candidate.internship_contract_received)
    end
  end
end
