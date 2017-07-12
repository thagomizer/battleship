class Board
  LETTERS = ('A'..'J').to_a
  NUMBERS = ('1'..'10').to_a

  attr_accessor :height, :width

  def initialize
    self.height = 10
    self.width  = 10
    @board  = Hash.new(".")
  end

  def in_range? location
    m = /([A-J])(\d+)/.match(location)

    return false unless m

    letter, number = /([A-J])(\d+)/.match(location).captures

    LETTERS.include?(letter) and NUMBERS.include?(number)
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

    str = LETTERS.map { |l|
      NUMBERS.map { |n| @board["#{l}#{n}"][0] }.join
    }.join("\n")
    str << "\n"

    str
  end
end
