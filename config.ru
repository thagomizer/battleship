# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

require './server'
run Sinatra::Application

require "google/cloud/logging"
require "google/cloud/debugger"
require "google/cloud/error_reporting"
require "google/cloud/trace"


logging = Google::Cloud::Logging.new
resource = Google::Cloud::Logging::Middleware.build_monitored_resource
logger = logging.logger "battleship-log", resource
use Google::Cloud::Logging::Middleware, logger: logger

require "google/cloud/debugger"
use Google::Cloud::Debugger::Middleware project: "battleship-176302",
                                        keyfile: "BATTLESHIP-dd853c51f7f9.json",
                                        service_name: "battleship",
                                        service_version: "v1"

use Google::Cloud::Debugger::Middleware

use Google::Cloud::ErrorReporting::Middleware

use Google::Cloud::Trace::Middleware
