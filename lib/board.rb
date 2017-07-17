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
