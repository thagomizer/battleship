# Copyright 2017 Google
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'board'

class Client
  DIRECTIONS = [:up, :down, :left, :right]
  LETTERS = ('A'..'J').to_a

  attr_accessor :game_id, :their_board, :my_board, :fleet

  def initialize game_id = "", fleet = []
    self.game_id     = game_id
    self.fleet       = fleet
    self.my_board    = Board.new
    self.their_board = Board.new
  end

  def place_ships
    self.fleet.each do |name, length|
      place_ship name, length
    end
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

      if locations.all? { |l| @my_board.in_range?(l) and @my_board.miss?(l) }
        locations.each do |l|
          self.my_board[l] = name
        end
        return
      end
    end
  end

  def guess
    "#{LETTERS.sample}#{Random.rand(10) + 1}"
  end

  def process_move move
    {:hit => @my_board.hit?(move)}
  end
end
