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
