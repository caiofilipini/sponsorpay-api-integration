require "sinatra"

class ApiIntegrationApp
  configure do
    set :views, "views"
  end

  get "/" do
    erb :form
  end
end
