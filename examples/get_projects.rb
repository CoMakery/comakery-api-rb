require 'dotenv'
Dotenv.load
require_relative '../comakery_api_signature.rb'
private_key = ENV['PRIVATE_KEY']
api_key = ENV['API_KEY']
api_url = ENV['API_URL']

request = Comakery::APISignature.new('body' => {
    'data' => {},
    'url' => api_url,
    'method' => 'GET'
}).sign(private_key)

puts request