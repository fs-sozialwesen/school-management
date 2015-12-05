class Positions < Array

  def initialize(pos_array)
    super()
    pos_array.each { |pos| self << pos }
  end

  def <<(position)
    raise ArgumentError, 'added object must be a Hash or a Position' unless position.class.in?([Hash, Position])
    position = Position.new(position) unless position.is_a?(Position)
    super position
  end

  def self.load(positions)
    return new([]) if positions.nil?
    positions = JSON.parse(positions) if positions.is_a?(String)
    # raise ArgumentError, 'positions must be (parsable) Array' unless positions.is_a?(Array)
    # positions.each { |pos| Position.new pos }
    new positions
  end

  def self.dump(positions)
    positions.map { |pos| Position.dump pos }
  end

  # def initialize(positions_hash = {})
  #   super
  #   positions_hash.values.each { |pos| self << pos }
  # end
  #
  # def <<(position)
  #   raise ArgumentError, 'added object must be a Hash or a Position' unless position.class.in?([Hash, Position])
  #   position = Position.new(position) unless position.is_a?(Position)
  #   self[position.education_subject_id.to_s] = position
  # end
  #
  # def self.dump(positions)
  #   res = {}
  #   positions.each { |edu_id, pos| res[edu_id.to_s] = Position.dump pos }
  #   res
  # end
  #
  # def self.load(positions)
  #   return new({}) if positions.nil?
  #   positions = JSON.parse(positions) if positions.is_a?(String)
  #   raise ArgumentError, 'positions must be (parsable) Hash' unless positions.is_a?(Hash)
  #   new positions
  # end
end
