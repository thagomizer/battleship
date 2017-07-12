require_relative '../lib/client'
require 'minitest/autorun'

class TestClient < Minitest::Test
  def test_initialize
    c = Client.new("gameID", [[:battleship, 5]])

    assert_equal "gameID", c.game_id

    assert c.my_board
    assert c.their_board
  end


end
