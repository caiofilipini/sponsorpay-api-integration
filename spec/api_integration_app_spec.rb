require File.expand_path("spec/spec_helper")
require "rack/test"
require "api_integration_app"

describe ApiIntegrationApp do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "GET /" do
    it "should render form" do
      get "/"
      last_response.should be_ok
      last_response.body.should match /<form/
    end
  end
  
end
