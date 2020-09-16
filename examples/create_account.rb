require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

API_ENDPOINT = API_URL + '/api/v1/accounts'

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY, {
        "body" => {
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
            "url" => API_ENDPOINT,
            "method" => "POST"
        }
    }
)

print_signed_request_result(result)