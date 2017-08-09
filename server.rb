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

get '/' do
  erb :index
end

get '/new_game' do
  g = Game.create!
  content_type :json

  { game_id: g.id }.to_json
end


## Takes a turn from the client, processes and
#  responds with a guess of its own
#
#  params:
#   { game_id: <id>,
#     response: { hit: [true|false],
#                 sunk: <ship name>},
#     guess:    { guess: <A7 or B4> }}
#
#  response is the same format as the request params, both in json

post '/turn' do
  params = JSON.parse(request.body.read)
  puts params
end
