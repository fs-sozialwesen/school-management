class Housing < JsonSerializer

  attribute :provided, Boolean, default: false
  attribute :costs,    String

  def self.provided(prov)
    { provided: prov }.to_json
  end

end
