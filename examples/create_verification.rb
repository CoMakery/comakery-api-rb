require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

account_id = 'cb3ef049-101b-4a25-8407-2e532c96ec36'
api_endpoint = API_URL + "/api/v1/accounts/#{account_id}/verifications"

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY, {"body" => {
    "data" =>
        {"verification" =>
             {"passed" => "true",
              "max_investment_usd" => "10000",
              "verification_type" => "aml-kyc",
              "created_at" => "2020-05-06 04:28:34 UTC"}},
    "url" => api_endpoint,
    "method" => "POST"}
    }
)

print_signed_request_result(result)