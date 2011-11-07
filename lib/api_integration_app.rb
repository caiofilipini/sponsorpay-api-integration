require "sinatra"
require "api/mobile_offer"

class ApiIntegrationApp
  configure do
    set :views, "views"
    set :public_folder, "public"
  end

  get "/" do
    erb :form
  end

  post "/offers" do
    offers = MobileOffer.offers_for params
    erb :offers, :locals => { :offers => offers }
  end
end
