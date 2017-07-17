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

require_relative '../lib/board'
require 'minitest/autorun'

class TestBoard < Minitest::Test
  def test_new
    b = Board.new

    assert_equal 10, b.height
    assert_equal 10, b.width

    assert_equal ".", b["C7"]
  end

  def test_accessing_cell
    b = Board.new

    b["B7"] = :submarine

    assert_equal :submarine, b["B7"]
  end

  def test_in_range?
    b = Board.new

    assert b.in_range?("B7")
    assert b.in_range?("A1")
    assert b.in_range?("A10")
    assert b.in_range?("J1")
    assert b.in_range?("J10")
    refute b.in_range?("X7")
    refute b.in_range?("B0")
    refute b.in_range?("B11")
    refute b.in_range?("")
    refute b.in_range?("142342")
  end

  def test_empty?
    b = Board.new

    assert b.empty?("F7")

    b["F7"] = :submarine

    refute b.empty?("F7")
  end

  def test_hit?
    b = Board.new

    refute b.hit?("D5")

    b["D5"] = :submarine

    assert b.hit?("D5")
  end

  def test_miss?
    b = Board.new

    assert b.miss?("D5")

    b["D5"] = :submarine

    refute b.miss?("D5")
  end

  def test_to_s
    b = Board.new

    expected = ""
    10.times do
      expected << "..........\n"
    end

    str = b.to_s

    assert_equal expected, b.to_s
  end
end
