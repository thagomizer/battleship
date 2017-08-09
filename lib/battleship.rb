# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'securerandom'
require 'irb'
require_relative 'client'

class Battleship
  FLEET = [[:battleship, 5],
           [:cruiser,    4],
           [:submarine,  3],
           [:frigate,    3],
           [:destroyer,  2]]
  SMALL_FLEET = [[:cruiser, 4]]

  attr_accessor :id, :client_a, :client_b

  def initialize
    @id = SecureRandom.uuid
    @client_a = Client.new(@id, FLEET)
    @client_b = Client.new(@id, FLEET)
  end

  def run
    @client_a.place_ships
    @client_b.place_ships

    puts "Client A Board"
    puts @client_a.my_board
    puts

    puts "Client B Board"
    puts @client_b.my_board
    puts

    loop do
      g = @client_a.guess
      r = @client_b.process_move g
      puts "A #{g}: B #{r}"

      if @client_b.lost?
        puts "B Lost"
        break
      end

      g = @client_b.guess
      r = @client_a.process_move g
      puts "B: #{g} A: #{r}"

      if @client_a.lost?
        puts "A Lost"
        break
      end
    end
  end
end
