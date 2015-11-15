class ApplicationOptions
  include Virtus.model

  attribute :by_phone,  Boolean, default: false
  attribute :by_email,  Boolean, default: false
  attribute :by_mail,   Boolean, default: false
  attribute :documents, String

  def by_options
    res = []
    res << 'Telefon' if by_phone
    res << 'E-Mail'  if by_email
    res << 'Post'    if by_mail
    res.compact
  end

  def to_hash
    {
      by_phone:  by_phone,
      by_email:  by_email,
      by_mail:   by_mail,
      documents: documents,
    }
  end

  def self.dump(options)
    options.to_hash
  end

  def self.load(options)
    case options
    when String then new(JSON.parse(options))
    when Hash then new(options)
    when nil then new
    end
  end
end
