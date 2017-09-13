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
require "google/cloud/logging"
require "google/cloud/debugger"
require "google/cloud/error_reporting"
require "google/cloud/trace"
require 'sinatra'
configure { set :server, :puma }

Google::Cloud.configure do |config|
  config.project_id = "stackdriver-hydridy-cloud-demo"
  config.keyfile = "StackdriverHybridDemo.json"
  
  config.debugger.service_name = "battleship"
  config.debugger.service_version = "v1"
  config.use_debugger = true
  
  config.error_reporting.service_name = "battleship"
  config.error_reporting.service_version = "v1"
  config.use_error_reporting = true

  config.logging.project_id = "stackdriver-hydridy-cloud-demo"
  config.logging.log_name = "battleship-log"
  config.use_logging = true

  config.use_trace = true
end

use Google::Cloud::Debugger::Middleware
use Google::Cloud::ErrorReporting::Middleware
use Google::Cloud::Logging::Middleware
use Google::Cloud::Trace::Middleware
