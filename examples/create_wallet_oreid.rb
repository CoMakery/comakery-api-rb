# WARNING: API implemenation of this request is pending

raise NotImplementedError
require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']


API_ENDPOINT = API_URL + "/api/v1/accounts/:managed_account_id/wallets/create"

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY,
    {"body" =>
         {"data" =>
              {"type" => "oreid",
               "blockchain" => "algorand_test",
               "provision" => ["republic_note"]
              }
         },
     "url" => API_ENDPOINT,
     "method" => "POST"
    }
)

print_signed_request_result(result)
