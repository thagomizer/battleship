# Copyright 2017 Google Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ENV["RACK_ENV"] = "test"
require "minitest/autorun"
require "rack/test"

require File.expand_path "../../server.rb", __FILE__

class ServerTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_root
    get "/"
    assert last_response.ok?
    assert last_response.body.include? "Battleship API"
  end

  def test_new_game
    get "/new_game"

    assert last_response.ok?

    data = JSON.parse(last_response.body)

    assert data["game_id"]

    assert_equal Game.last.id, data["game_id"]
  end
end
