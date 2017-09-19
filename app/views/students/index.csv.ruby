require 'csv'

response.headers['Content-Disposition'] = %Q(attachment; filename="auszubildende-#{Time.now}.csv")

CSV.generate(encoding: 'UTF-8', col_sep: ';', force_quotes: true) do |csv|
  csv << %w(KLasse
            Anrede Vorname Nachname Geburtsdatum Geburtsort
            Straße PLZ Ort
            E-Mail Telefon Mobil)
  @students.each do |student|
    address = student.address
    contact = student.contact

    csv << [
      student.course&.name,

      gt(:salut, student),
      student.first_name,
      student.last_name,
      ldate(student.date_of_birth),
      student.place_of_birth,

      address.street,
      address.zip,
      address.city,

      contact.email,
      contact.phone,
      contact.mobile,
    ]
  end
end
