$:.push File.expand_path("../lib", __FILE__)

require "rspec"

RSpec.configure do |config|
  config.mock_framework = :mocha
end
