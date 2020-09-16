require 'dotenv'
require_relative '../comakery_api_signature.rb'
require 'httparty'
require 'pp'

Dotenv.load
PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']
UNIQUE_MANAGED_ACCOUNT_ID = rand(36**31..36**32-1).to_i.to_s(36)

api_endpoint = API_URL + '/api/v1/accounts'

signed_query = Comakery::APISignature.new(
    {"body" => {
        "data" =>
            {"account" =>
                 {"managed_account_id" => UNIQUE_MANAGED_ACCOUNT_ID,
                  "email" => "me+#{UNIQUE_MANAGED_ACCOUNT_ID}@example.com",
                  "first_name" => "Eva",
                  "last_name" => "Smith",
                  "nickname" => "hunter-#{UNIQUE_MANAGED_ACCOUNT_ID}",
                  "date_of_birth" => "1990/01/01",
                  "country" => "United States of America",
                 }},
        "url" => api_endpoint,
        "method" => "POST"}
    }).sign(PRIVATE_KEY)

response = HTTParty.post(
    api_endpoint,
    query: signed_query,
    headers: {
        'Api-Key': API_KEY
    }
)

puts signed_query
puts "\n\nAPI ENDPOINT"
pp api_endpoint
puts "\n\nSIGNED QUERY PARAMS:"
pp signed_query
puts "\n\nAPI REQUEST URI"
pp response.request.last_uri.to_s
puts "\n\n"
puts "\n\nAPI RESPONSE"
pp response.to_s
puts "\n\n"