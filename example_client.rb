SERVER_ADDRESS = "https://battleship-176302.appspot.com/"

class BattleshipClient

  def initialize
    place_ships
  end

  def run
    game_id = new_game

    g = guess
    server_response = turn game_id, {hit: false, sunk: nil}, g

    loop do
      opponent_move = server_response["guess"]["guess"]

      response_to_opponent = respond_to_move opponent_move
      g = guess

      server_response = turn game_id, response_to_opponent, g
    end
  end

  def random_guess
    "#{%w[A B C D E F G H I J].sample}#{Random.rand(10) + 1}"
  end

  def guess
    # Replace the call to random_guess with your own guessing logic
    random_guess
  end

  def respond_to_move move
    # This is where you respond to your opponent's move
    # You need to determine if the move hit one of your ships or missed them
    # And if it hit a ship, was the ship sunk.
    #
    # I recommend this method return a hash that looks like this
    #  { hit: true, sunk: "Submarine" }
    #   or
    #  { hit: false, sunk: nil }
  end

  def place_ships
    # Place the ships on your board here
    # when you are starting it helps to have static ship placement
    #
    # The ships are:
    #   Battleship - Length 5
    #   Cruiser    - Length 4
    #   Submarine  - Length 3
    #   Frigate    - Length 3
    #   Destroyer  - Length 2
  end

  # API Protocol
  # Do not change
  def new_game
    uri = URI("#{SERVER_ADDRESS}/new_game")
    response = Net::HTTP.get(uri)

    game_id = JSON.parse(response)["game_id"]
  end

  def turn game_id, response_to_last_move, guess
    @turn_id ||= 0
    @turn_id += 1

    request = {}

    response_to_last_move[:turn_id] = @turn_id

    request[:response] = response_to_last_move
    request[:guess] = { guess: guess, turn_id = @turn_id += 1 }

    uri = URI("#{SERVER_ADDRESS}/turn")
    response = Net::HTTP.post(uri,
                              request.to_json,
                              "Content-Type" => "application/json")

  end

end
