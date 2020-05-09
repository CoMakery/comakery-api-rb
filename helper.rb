require 'dotenv'
require 'pp'
require 'json'
Dotenv.load

def print_signed_request_result(result)
  puts "\n\nAPI ENDPOINT"
  pp result[:signed_query]['body']['url']
  puts "\n\nSIGNED QUERY PARAMS:"
  pp result[:signed_query]
  puts "\n\nAPI REQUEST URI"
  pp result[:response].request.last_uri.to_s
  puts "\n\n"
  puts "\n\nAPI RESPONSE"
  pp JSON.parse(result[:response].to_s)
  puts "\n\n"
end