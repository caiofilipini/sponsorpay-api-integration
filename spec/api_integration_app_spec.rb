require File.expand_path("spec/spec_helper")
require "rack/test"
require "api_integration_app"

describe ApiIntegrationApp do

  include Rack::Test::Methods

  def app
    ApiIntegrationApp
  end

  it "should render Hello World" do
    get "/"
    last_response.should be_ok
    last_response.body.should == "Hello world!"
  end
  
end
