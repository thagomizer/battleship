require 'securerandom'
require_relative 'client'

class Game
  attr_accessor :id, :client_a, :client_b

  def initialize
    @id = SecureRandom.uuid
    @client_a = Client.new(@id)
    @client_b = Client.new(@id)
  end
end
