class Board
  attr_accessor :height, :width

  def initialize
    self.height = 10
    self.width  = 10
    @board  = Hash.new(".")
  end

  def [] location
    @board[location]
  end

  def []= location, value
    @board[location] = value
  end

  def hit? location
    @board[location] != "."
  end

  def miss? location
    @board[location] == "."
  end

  def to_s
    str = ""

    str = ('A'..'J').map { |l|
      (1..10).map { |n| @board["#{l}#{n}"][0] }.join
    }.join("\n")
    str << "\n"

    str
  end
end
