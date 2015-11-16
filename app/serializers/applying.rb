class Applying < JsonSerializer

  attribute :by_phone,  Boolean, default: false
  attribute :by_email,  Boolean, default: false
  attribute :by_mail,   Boolean, default: false
  attribute :documents, String

  def self.by_mail(yes_or_no)
    ['applying @> ?', { by_mail: yes_or_no }.to_json ]
  end

  def self.by_email(yes_or_no)
    ['applying @> ?', { by_email: yes_or_no }.to_json ]
  end

  def self.by_phone(yes_or_no)
    ['applying @> ?', { by_phone: yes_or_no }.to_json ]
  end

end
