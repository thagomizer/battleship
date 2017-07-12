require_relative '../lib/board'
require 'minitest/autorun'

class TestBoard < Minitest::Test
  def test_new
    b = Board.new

    assert_equal 10, b.height
    assert_equal 10, b.width

    assert_equal ".", b["C7"]
  end

  def test_set_cell
    b = Board.new

    b["B7"] = :submarine

    assert_equal :submarine, b["B7"]
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
