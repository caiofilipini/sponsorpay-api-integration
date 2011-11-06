require File.expand_path("spec/spec_helper")
require "json"
require "api/mobile_offer"

describe MobileOffer do

  let(:params) do
    {
      :uid => "player1",
      :pub0 => "campaign2",
      :page => 1
    }
  end

  describe "#offers_for" do
    before :each do
      @response = mock("Response")
      @response.stubs(:body).returns(response_as_json)
      MobileOffer.stubs(:get).returns(@response)
    end

    it "should return offers as an Array" do
      MobileOffer.offers_for(params).should be_an Array
    end

    context "API" do
      it "should define base_uri" do
        MobileOffer.base_uri.should == "http://api.sponsorpay.com"
      end

      it "should expect JSON response" do
        expect_parameter :format, "json"
        MobileOffer.offers_for params
      end

      it "should request offers" do
        MobileOffer.expects(:get).with("/feed/v1/offers.json", anything).returns(@response)

        offers = MobileOffer.offers_for params
        offer = offers.first
        offer["title"].should match /Fussballmanager/
      end
    end

    context "security" do
      it "should compute hash key based on api key and parameters" do
        key = mock("HashKey")
        key.stubs(:compute).returns nil
        HashKey.expects(:new).with("b07a12df7d52e6c118e5d47d3f9e60135b109a1f", has_key(:uid)).returns(key)

        MobileOffer.offers_for params
      end
    end

    context "parameters" do
      context "from application" do
        [:appid, :device_id, :locale, :ip, :offer_types].each do |param_name|
          it "should include #{param_name}" do
            expect_parameter param_name
            MobileOffer.offers_for params
          end
        end

        it "should include current timestamp" do
          now = Time.now.to_i
          freeze_time_to now

          expect_parameter :timestamp, now
          MobileOffer.offers_for params
        end

        it "should append hash key to parameters before sending API request" do
          expect_parameter :hashkey
          MobileOffer.offers_for params
        end
      end

      context "defined by user" do
        [:uid, :pub0, :page].each do |param_name|
          it "should include #{param_name}" do
            expect_parameter param_name, params[param_name]
            MobileOffer.offers_for params
          end
        end
      end
    end
  end

  private

  def expect_parameter(param, value = nil)
    MobileOffer.expects(:get).with(anything, has_value(has_key(param))).returns(@response) if value.nil?
    MobileOffer.expects(:get).with(anything, has_value(has_entry(param => value))).returns(@response) unless value.nil?
  end

  def freeze_time_to(frozen)
    time = mock("Time")
    time.stubs(:to_i).returns(frozen)
    Time.stubs(:now).returns(time)
  end

  def response_as_json
    response = <<-JSON
    {\"code\":\"OK\",\"message\":\"Ok\",\"count\":1,\"pages\":1,\"information\":{\"app_name\":\"Demo iframe for publisher - do not touch\",\"appid\":157,\"virtual_currency\":\"Coins\",\"country\":\"DE\",\"language\":\"DE\",\"support_url\":\"http://api.sponsorpay.com/support?appid=157&uid=player1\"},\"offers\":[{\"title\":\"Mobile FC - Werde Fussballmanager\",\"teaser\":\"Downloaden und STARTEN\",\"required_actions\":\"Downloaden und STARTEN\",\"link\":\"http://api.sponsorpay.com/mbrowser?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&lpid=23947&pub0=campaign2&uid=player1\",\"offer_types\":[{\"offer_type_id\":101,\"readable\":\"download\"},{\"offer_type_id\":112,\"readable\":\"free\"}],\"payout\":14000,\"time_to_payout\":{\"amount\":1500,\"readable\":\"25 Minuten\"},\"thumbnail\":{\"lowres\":\"http://cdn3.sponsorpay.com/assets/5135/MobileFC_square_60.\",\"hires\":\"http://cdn3.sponsorpay.com/assets/5135/MobileFC_square_175.\"}}]}
    JSON
    response
  end

end