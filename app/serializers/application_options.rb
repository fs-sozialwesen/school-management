class ApplicationOptions < JsonSerializer

  attribute :by_phone,  Boolean, default: false
  attribute :by_email,  Boolean, default: false
  attribute :by_mail,   Boolean, default: false
  attribute :documents, String

  def self.by_mail;  { by_mail: true  }.to_json; end
  def self.by_email; { by_email: true }.to_json; end
  def self.by_phone; { by_phone: true }.to_json; end

end
