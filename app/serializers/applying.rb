class Applying < JsonSerializer

  attribute :by_phone,  Boolean, default: false
  attribute :by_email,  Boolean, default: false
  attribute :by_mail,   Boolean, default: false
  attribute :documents, String

  def by
    attributes.slice(:by_mail, :by_email, :by_phone).select {|k,v| v }.keys
  end

  def self.by(via)
    unless via.in?(%i(by_mail by_email by_phone))
      raise ArgumentError, 'via must be one of :by_mail, :by_email, :by_phone'
    end
    { via => true }.to_json
  end

end
