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

class Board
  LETTERS = ('A'..'J').to_a
  NUMBERS = ('1'..'10').to_a

  attr_accessor :height, :width

  def initialize
    self.height = 10
    self.width  = 10
    @board  = Hash.new { |h, k| h[k] = [] }
  end

  def in_range? location
    m = /([A-J])(\d+)/.match(location)

    return false unless m

    letter, number = /([A-J])(\d+)/.match(location).captures

    LETTERS.include?(letter) and NUMBERS.include?(number)
  end

  def [] location
    @board.each do |value, locations|
      return value if locations.include?(location)
    end
    return "."
  end

  def []= location, value
    @board[value] << location
  end

  def hit? location
    @board.values.any? { |locations| location.include?(location) }
  end

  def empty? location
    @board.values.none? { |locations| locations.include?(location) }
  end

  alias_method :miss?, :empty?

  def to_s
    inverted = Hash.new(".")
    @board.each do |ship, locations|
      locations.each do |l|
        inverted[l] = ship
      end
    end

    str = " 1234567890\n"

    str += LETTERS.map { |l|
      l + NUMBERS.map { |n| inverted["#{l}#{n}"][0] }.join
    }.join("\n")
    str << "\n"

    str
  end

  def marshal_dump
    @board.to_a
  end

  def marshal_load data
    @board  = Hash.new { |h, k| h[k] = [] }

    data.each do |location, value|
      @board[location] = value
    end
  end
end
