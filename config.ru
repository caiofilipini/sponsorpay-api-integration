$:.push File.expand_path("../lib", __FILE__)

require "rack"
require "api_integration_app"

run Sinatra::Application
