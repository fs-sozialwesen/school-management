require 'csv'

response.headers['Content-Disposition'] = %Q(attachment; filename="organisationsn-#{Time.now}.csv")

CSV.generate(encoding: 'UTF-8', col_sep: ';', force_quotes: true) do |csv|
  csv << %w(Name Bemerkungen
            Straße PLZ Ort
            Ansprechpartner E-Mail Telefon Fax Mobil Homepage)
  @organisations.each do | organisation |
    address = organisation.address
    contact = organisation.contact

    csv << [
      organisation.name,
      organisation.comments,

      address.street,
      address.zip.to_s,
      address.city,

      contact.person,
      contact.email,
      contact.phone.to_s,
      contact.fax.to_s,
      contact.mobile.to_s,
      contact.homepage,
    ]
  end
end
