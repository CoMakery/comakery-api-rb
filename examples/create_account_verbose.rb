require 'dotenv'
require_relative '../comakery_api_signature.rb'
require 'httparty'
require 'pp'

Dotenv.load
PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

api_endpoint = API_URL + '/api/v1/accounts'

signed_query = Comakery::APISignature.new(
    {"body" => {
        "data" =>
            {"account" =>
                 {"managed_account_id" => "ae0344e2-fff8-466b-8de7-5941ec7115c2",
                  "email" => "me+bc6b1da493d156f06d2fb85a044ba01146796f52@example.com",
                  "first_name" => "Eva",
                  "last_name" => "Smith",
                  "nickname" => "hunter-36546fef2bc6c93536aaf0a7e3c374d645a00d59",
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