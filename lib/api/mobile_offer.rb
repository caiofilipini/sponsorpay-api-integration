require "httparty"

class MobileOffer
  include HTTParty

  base_uri "http://api.sponsorpay.com"

  def self.request_for(params)
    params.merge! app_params
    params.merge! :hashkey => hash_key_for(params)
    response = self.get("/feed/v1/offers.json", :query => params)
    JSON.parse response.body
  end

  private

  def self.hash_key_for(params)
    HashKey.new(api_key, params).compute
  end

  def self.api_key
    "b07a12df7d52e6c118e5d47d3f9e60135b109a1f"
  end

  def self.app_params
    {
      :appid => 157,
      :format => "json",
      :device_id => "2b6f0cc904d137be2e1730235f5664094b831186",
      :locale => "de",
      :ip => "109.235.143.113",
      :offer_types => 112,
      :timestamp => Time.now.to_i
    }
  end
end
