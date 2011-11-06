$:.push File.expand_path("../lib", __FILE__)

require "rspec"

RSpec.configure do |config|
  config.mock_framework = :mocha
end

def sha1_for(string)
  Digest::SHA1.hexdigest string
end

def response_as_json
  response = <<-JSON
    {\"code\":\"OK\",\"message\":\"Ok\",\"count\":1,\"pages\":1,\"information\":{\"app_name\":\"Demo iframe for publisher - do not touch\",\"appid\":157,\"virtual_currency\":\"Coins\",\"country\":\"DE\",\"language\":\"DE\",\"support_url\":\"http://api.sponsorpay.com/support?appid=157&uid=player1\"},\"offers\":[{\"title\":\"Mobile FC - Werde Fussballmanager\",\"teaser\":\"Downloaden und STARTEN\",\"required_actions\":\"Downloaden und STARTEN\",\"link\":\"http://api.sponsorpay.com/mbrowser?appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&lpid=23947&pub0=campaign2&uid=player1\",\"offer_types\":[{\"offer_type_id\":101,\"readable\":\"download\"},{\"offer_type_id\":112,\"readable\":\"free\"}],\"payout\":14000,\"time_to_payout\":{\"amount\":1500,\"readable\":\"25 Minuten\"},\"thumbnail\":{\"lowres\":\"http://cdn3.sponsorpay.com/assets/5135/MobileFC_square_60.\",\"hires\":\"http://cdn3.sponsorpay.com/assets/5135/MobileFC_square_175.\"}}]}
  JSON
  response
end
