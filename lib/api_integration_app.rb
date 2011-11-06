require "sinatra"

class ApiIntegrationApp < Sinatra::Base
  get "/" do
    "Hello world!"
  end
end
