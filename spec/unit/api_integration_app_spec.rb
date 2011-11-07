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

  context "POST /offers" do
    let(:params) do
      {
        "uid" => "player1",
        "pub0" => "campaign2",
        "page" => "2"
      }
    end

    it "should request offers via API" do
      MobileOffer.expects(:offers_for).with(params)
      post "/offers", params
    end

    it "should render received offers" do
      MobileOffer.expects(:offers_for).with(params).returns(JSON.parse(response_as_json)["offers"])

      post "/offers", params
      last_response.should be_ok
      last_response.body.should match /Fussballmanager/
    end

    it "should render message when no offers have been found" do
      MobileOffer.expects(:offers_for).returns([])

      post "/offers", params
      last_response.should be_ok
      last_response.body.should match /No\soffers/
    end
  end
  
end
