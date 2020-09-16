require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

API_ENDPOINT = API_URL + '/api/v1/accounts'
UNIQUE_MANAGED_ACCOUNT_ID = rand(36**31..36**32-1).to_i.to_s(36)

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY, {
        "body" => {
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
            "url" => API_ENDPOINT,
            "method" => "POST"
        }
    }
)

print_signed_request_result(result)