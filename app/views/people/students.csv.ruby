require 'csv'

response.headers['Content-Disposition'] = %Q(attachment; filename="auszubildende-#{Time.now}.csv")

CSV.generate(encoding: 'UTF-8', col_sep: ';', force_quotes: true) do |csv|
  csv << %w(KLasse
            Anrede Vorname Nachname Geburtsdatum Geburtsort
            Straße PLZ Ort
            E-Mail Telefon Mobil)
  @students.each do | person |
    student = person.as_student
    address        = person.address
    contact        = person.contact

    csv << [
      student.course&.name,

      gt(:salut, person),
      person.first_name,
      person.last_name,
      ldate(person.date_of_birth),
      person.place_of_birth,

      address.street,
      address.zip,
      address.city,

      contact.email,
      contact.phone,
      contact.mobile,
    ]
  end
end
