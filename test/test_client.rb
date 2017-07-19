# Copyright 2017 Google Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
    c = Client.new("gameID", [[:cruiser, 3]])

    locations = c.place_ship :cruiser, 3
    assert_equal 3, locations.length

    assert_equal 3, c.my_board.to_s.each_char.count { |l| l == "c" }

    locations.each do |l|
      assert_equal :cruiser, c.my_board[l]
    end
  end

  def test_place_ships
    c = Client.new("gameID", [[:battleship, 5],
                              [:cruiser, 4],
                              [:submarine, 3],
                              [:frigate, 3],
                              [:destroyer, 2]])

    c.place_ships

    assert_equal 5, c.my_board.to_s.each_char.count { |l| l == "b" }
    assert_equal 4, c.my_board.to_s.each_char.count { |l| l == "c" }
    assert_equal 3, c.my_board.to_s.each_char.count { |l| l == "s" }
    assert_equal 3, c.my_board.to_s.each_char.count { |l| l == "f" }
    assert_equal 2, c.my_board.to_s.each_char.count { |l| l == "d" }

    c.fleet.each do |name, len, locations|
      assert_equal len, locations.length

      locations.each do |l|
        assert_equal name, c.my_board[l]
      end
    end
  end

  def test_guess
    c = Client.new()

    g = c.guess

    assert c.their_board.in_range?(g)
  end

  def test_process_move
    c = Client.new("gameID", [[:destroyer, 2, ["A7", "A8"]]])

    assert_equal false, c.process_move("F3")[:hit]

    assert_equal true, c.process_move("A7")[:hit]

    expected = {:hit => true, :sunk => :destroyer }

    assert_equal expected, c.process_move("A8")
  end

  def test_lost?
    c = Client.new("gameID", [[:destroyer, 2, ["A7", "A8"]]])

    c.process_move("A7")
    c.process_move("A8")

    assert c.lost?
  end
end
