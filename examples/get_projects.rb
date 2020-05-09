require_relative '../helper.rb'
require_relative '../comakery_api_signature.rb'

PRIVATE_KEY = ENV['PRIVATE_KEY']
API_KEY = ENV['API_KEY']
API_URL = ENV['API_URL']

api_endpoint = API_URL + '/api/v1/projects'

result = Comakery::APISignature.signed_request(
    API_KEY,
    PRIVATE_KEY, {
        'body' => {
            'data' => "",
            'url' => api_endpoint,
            'method' => 'GET'
        }
    }
)

print_signed_request_result(result)