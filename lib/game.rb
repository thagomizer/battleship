require 'securerandom'
require_relative 'client'

class Game
  FLEET = [[:battleship, 5],
           [:cruiser,    4],
           [:submarine,  3],
           [:frigate,    3],
           [:destroyer,  2]]


  attr_accessor :id, :client_a, :client_b

  def initialize
    @id = SecureRandom.uuid
    @client_a = Client.new(@id, FLEET)
    @client_b = Client.new(@id, FLEET)
  end
end
