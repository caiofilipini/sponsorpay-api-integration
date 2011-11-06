require "sinatra"
require "api/mobile_offer"

class ApiIntegrationApp
  configure do
    set :views, "views"
  end

  get "/" do
    erb :form
  end

  post "/offers" do
    offers = MobileOffer.offers_for params
    erb :offers, :locals => { :offers => offers }
  end
end
