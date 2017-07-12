require_relative '../lib/client'
require 'minitest/autorun'

class TestClient < Minitest::Test
  def test_initialize
    c = Client.new("gameID", [[:battleship, 5]])

    assert_equal "gameID", c.game_id
    assert_equal [[:battleship, 5]], c.fleet

    assert c.my_board
    assert c.their_board
  end

  def test_place_ship
    c = Client.new("gameID", [])

    c.place_ship :cruiser, 3

    assert_equal 3, c.my_board.to_s.each_char.count { |l| l == "c" }
  end

  def test_place_ships
    c = Client.new("gameID", [[:battleship, 5], [:cruiser, 3]])

    c.place_ships

    assert_equal 5, c.my_board.to_s.each_char.count { |l| l == "b" }
    assert_equal 3, c.my_board.to_s.each_char.count { |l| l == "c" }
  end
end
