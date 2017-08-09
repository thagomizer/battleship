# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#      http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "sinatra"
require "sinatra/activerecord"
require_relative "models/game"
require_relative "models/turn"
require_relative "lib/client"

get '/' do
  erb :index
end

get '/new_game' do
  g = Game.create!

  # Create a client, place_ships, and create turn 0

  content_type :json
  { game_id: g.id }.to_json
end


## Takes a turn from the client, processes and
#  responds with a guess of its own
#
#  params:
#   { game_id: <id>,
#     response: { hit: [true|false],
#                 sunk: <ship name>,
#                 turn_id: i },
#     guess:    { guess: <A7 or B4>,
#                 turn_id: i + 1}}
#
#  response is the same format as the request params, both in json

post '/turn' do
  body = request.body.read
  params = JSON.parse(body)

  response = {}

  g = Game.find( params["game_id"] )

  turns = Turn.where(game_id: g.id)
  last = turns.last

  # Load in state from the previous turns and create a new client object.
  if last
    c = Marshal.load(last.state)
  else
    c = Client.new
  end

  # Process move, create a turn record for the client's turn

  response[:response] = c.process_move params["guess"]["guess"]
  response[:response][:turn_id] = params["guess"]["turn_id"]

  t = Turn.new
  t.game_id = g.id
  t.state = Marshal.dump(c)
  t.body = params
  t.turn_id = params["guess"]["turn_id"]
  t.save!

  # Figure out your response, create a turn record to record it
  guess = c.guess
  t = Turn.new
  t.game_id = g.id
  t.state = Marshal.dump(c)
  t.turn_id = params["guess"]["turn_id"] + 1

  # Send response

  response[:game_id] = g.id

  response[:guess] = { guess: guess, turn_id: t.turn_id}

  content_type :json
  response.to_json
end
