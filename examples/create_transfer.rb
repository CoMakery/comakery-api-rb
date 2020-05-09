require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

project_id = 112
API_ENDPOINT = API_URL + "/api/v1/projects/#{project_id}/transfers"
ACOUNT_ID = 'cb3ef049-101b-4a25-8407-2e532c96ec36'

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY,
    {
        "body" =>
            {"data" =>
                 {"transfer" =>
                      {"amount" => "1000.000000000000000000",
                       "quantity" => "2.00",
                       "total_amount" => "2000.000000000000000000",
                       "source" => "bought", # this is the transfer type
                       "description" => "lorem ipsum",
                       "account_id" => ACOUNT_ID}},
             "url" => API_ENDPOINT,
             "method" => "POST"
            }
    }
)

print_signed_request_result(result)


