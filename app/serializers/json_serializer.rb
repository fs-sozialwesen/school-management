class JsonSerializer
  include Virtus.model

  def self.dump(options)
    options.attributes.to_h
  end

  def self.load(options)
    case options
    when String then new(JSON.parse(options))
    when Hash then new(options)
    when nil then new
    end
  end
end
