require 'dotenv'
require_relative '../comakery_api_signature.rb'
require 'httparty'
require 'pp'

Dotenv.load
PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

account_id = 'cb3ef049-101b-4a25-8407-2e532c96ec36'
api_endpoint = API_URL + "/api/v1/accounts/#{account_id}/verifications"

signed_query = Comakery::APISignature.new(
    {"body"=>
         {"data"=>"",
          "url"=>
              api_endpoint,
          "method"=>"GET"
         },
}).sign(PRIVATE_KEY)

response = HTTParty.get(
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