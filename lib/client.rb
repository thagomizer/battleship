require 'board'

class Client
  DIRECTIONS = [:up, :down, :left, :right]
  LETTERS = ('A'..'J').to_a

  attr_accessor :game_id, :their_board, :my_board, :fleet

  def initialize game_id, fleet
    self.game_id     = game_id
    self.fleet       = fleet
    self.my_board    = Board.new
    self.their_board = Board.new
  end
  def place_ship name, length
    loop do
      dir = DIRECTIONS.sample
      letter = LETTERS.sample
      number = Random.rand(10)

      locations = []

      length.times do
        locations << "#{letter}#{number}"

        case dir
        when :right
          number += 1
        when :left
          number -= 1
        when :up
          letter = (letter.ord - 1).chr
        when :down
          letter = letter.next
        end
      end

      if locations.all? { |l| self.my_board.in_range?(l) }
        locations.each do |l|
          self.my_board[l] = name
        end
        return
      end
    end
  end
end
