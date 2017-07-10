require 'board'

class Client
  attr_accessor :game_id, :their_board, :my_board

  def initialize game_id
    self.game_id = game_id
    self.my_board = Board.new
    self.their_board = Board.new
  end
end
