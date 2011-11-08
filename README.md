# Sponsorpay API Integration
Simple Ruby Sinatra web application to interact with SponsorPay's Mobile API.

## Testing

### Unit tests
All the code was written using Behaviour-Driven Development with RSpec.

### Integration tests
There is a simple integration test at `spec/integration` that was written using `Rack::Test`. It simulates parameters received from the form but makes a real call to the API and guarantees that the call was successful and data received is valid.

## Dependencies

### Application
* Sinatra
* HTTParty

### Tests
* RSpec
* Rack::Test
* Mocha

## Notes and possible improvements

### About the code
* Right now, any response code other than "OK" sent by the API ends with a "No offers" message rendered on the page.
* Error handling could be improved a lot, but I believe that it should be enough for this exercise.
* Application parameters, such as api key and appid would be better placed on a config file. 

### Heroku
* The application is deployed at Heroku: http://sponsorpay-api-integration.heroku.com
