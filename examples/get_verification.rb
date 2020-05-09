require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

account_id = 'cb3ef049-101b-4a25-8407-2e532c96ec36'
API_ENDPOINT = API_URL + "/api/v1/accounts/#{account_id}/verifications"

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY, {
        "body" =>
            {"data" => "",
             "url" =>
                 API_ENDPOINT,
             "method" => "GET"
            },
    }
)

print_signed_request_result(result)