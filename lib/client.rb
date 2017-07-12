require 'board'

class Client
  attr_accessor :game_id, :their_board, :my_board

  attr_accessor :game_id, :their_board, :my_board, :fleet

  def initialize game_id, fleet
    self.game_id     = game_id
    self.fleet       = fleet
    self.my_board    = Board.new
    self.their_board = Board.new
  end
end
