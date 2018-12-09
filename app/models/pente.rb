class Pente

  FIELD_SIZE = 19
  P1 = 0
  P2 = 1

  attr_reader :turn, :board, :captured, :winner

  def initialize(turn: P1, board: {}, captured: { P1 => 0, P2 => 0 }, winner: nil)
    @turn = turn.to_i
    @board = board.map { |k,v| [k.gsub(/[\[\] ]/, '').split(',').map(&:to_i), v] }.to_h
    @captured = captured.map { |k,v| [k.to_i, v.to_i] }.to_h
    @winner = winner.blank? ? nil : winner.to_i
  end

  def players
    [P1, P2]
  end

  def set_stone(x, y)
    raise 'invalid move' unless @board[[x, y]].nil?
    @board[[x, y]] = @turn
    check_state x, y
    @turn = other_player
  end

  def other_player
    1 - @turn
  end

  def stone_at(x, y)
    @board[[x, y]]
  end

  def check_state(x, y)
    check_five x, y
    check_captured x, y
  end

  def check_five(x, y)
    [-1, 0, 1].each do |x_offset|
      [-1, 0, 1].each do |y_offset|
        next if x_offset == 0 && y_offset == 0
        next unless [1, 2, 3, 4].map { |i| @board[[x + (i * x_offset), y + (i * y_offset)]] }.uniq == [@turn]
        @winner = @turn
      end
    end
  end

  def check_captured(x, y)
    [-1, 0, 1].each do |x_offset|
      [-1, 0, 1].each do |y_offset|
        next if x_offset == 0 && y_offset == 0
        next if @board[[x + (x_offset * 3), y + (y_offset * 3)]] != @turn
        next if @board[[x + (x_offset * 2), y + (y_offset * 2)]] != other_player
        next if @board[[x + (x_offset * 1), y + (y_offset * 1)]] != other_player
        @board[[x + (x_offset * 2), y + (y_offset * 2)]] = nil
        @board[[x + (x_offset * 1), y + (y_offset * 1)]] = nil
        @captured[@turn] +=2
      end
    end

    @winner = @turn if @captured[@turn] == 10
  end
end
