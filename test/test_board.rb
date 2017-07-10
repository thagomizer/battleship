require_relative '../lib/board'
require 'minitest/autorun'

class TestBoard < Minitest::Test
  def test_new
    b = Board.new

    assert_equal 10, b.height
    assert_equal 10, b.width

    assert_equal ".", b.get_cell("C7")
  end

  def test_set_cell
    b = Board.new

    b.set_cell "B7", :submarine

    assert_equal :submarine, b.get_cell("B7")
  end

  def test_hit?
    b = Board.new

    refute b.hit?("D5")

    b.set_cell "D5", :submarine

    assert b.hit?("D5")
  end

  def test_miss?
    b = Board.new

    assert b.miss?("D5")

    b.set_cell "D5", :submarine

    refute b.miss?("D5")
  end
end
