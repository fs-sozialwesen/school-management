require 'csv'

response.headers['Content-Disposition'] = %Q(attachment; filename="praktikumsplätze-#{Time.now}.csv")

CSV.generate(encoding: 'UTF-8', col_sep: ';', force_quotes: true) do |csv|
  csv << %w(Einrichtung Träger
            Straße PLZ Ort
            Ansprechpartner E-Mail Telefon Fax Mobil Homepage
            Unterkunft Kosten
            Bew_Tel Bew_Post Bew_Email Bew_Dokumente
            )
  @internship_positions.each do | internship_position |
    address = internship_position.address
    contact = internship_position.contact
    housing = internship_position.housing
    applying = internship_position.applying

    csv << [
      internship_position.name,
      internship_position.organisation.name,
      # internship_position.description.to_s.gsub("\n", ' '),

      address.street,
      address.zip.to_s,
      address.city,

      contact.person,
      contact.email,
      contact.phone.to_s,
      contact.fax.to_s,
      contact.mobile.to_s,
      contact.homepage,

      (housing.provided ? 'ja' : ''),
      housing.costs,

      (applying.by_phone ? 'ja' : ''),
      (applying.by_mail ? 'ja' : ''),
      (applying.by_email ? 'ja' : ''),
      applying.documents,
    ]
  end
end
