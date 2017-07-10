class Board
  attr_accessor :height, :width

  def initialize
    self.height = 10
    self.width  = 10
    @board  = Hash.new(".")
  end

  def get_cell location
    @board[location]
  end

  def set_cell location, value
    @board[location] = value
  end

  def hit? location
    @board[location] != "."
  end

  def miss? location
    @board[location] == "."
  end
end
