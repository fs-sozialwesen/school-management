require 'csv'

response.headers['Content-Disposition'] = %Q(attachment; filename="lehrer-#{Time.now}.csv")

CSV.generate(encoding: 'UTF-8', col_sep: ';', force_quotes: true) do |csv|
  csv << %w(Klassen
            Anrede Vorname Nachname Geburtsdatum Geburtsort
            Straße PLZ Ort
            E-Mail Telefon Mobil)
  @teachers.each do | teacher |
    person         = teacher.person
    address        = person.address
    contact        = person.contact

    csv << [
      teacher.courses.pluck(:name).join(', '),

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
