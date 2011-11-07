require File.expand_path("spec/spec_helper")
require "rack/test"
require "api_integration_app"

describe "SponsorPay API Integration Specs" do

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  context "with valid parameters" do
    let(:params) do
      {
        :uid => "player1",
        :pub0 => "campaign2",
        :page => 1
      }
    end

    it "should render offers requested via API" do
      post "/offers", params
      last_response.should be_ok
      last_response.body.should match /Found\s.*offer\(s\)/
    end
  end

  context "with invalid parameters" do
    let(:params) do
      {
        :uid => "player1",
        :pub0 => "campaign2",
        :page => 5
      }
    end

    it "should render message informing that no offers have been found" do
      post "/offers", params
      last_response.should be_ok
      last_response.body.should match /No\soffers/
    end
  end

end
