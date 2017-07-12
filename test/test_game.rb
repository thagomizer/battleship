require_relative '../lib/game'
require 'minitest/autorun'

class TestGame < Minitest::Test
  def test_initialize
    g = Game.new

    assert g.id

    assert g.client_a
    assert g.client_b
  end
end
