# CoMakery API Ruby 

This an API wrapper for making requests to the CoMakery API. It implements signing and verifying CoMakery API requests with Ed25519 digital signature public & private keys.

## Installation

To get started:

0. `git clone git@github.com:CoMakery/comakery-api-rb.git`
1. `cd comakery-api-rb` and run `bundle install`
1. Get your API key by contacting CoMakery
1. Generate a public/private keypair in ed25519 format for signing your API requests.
1. Give the public key of your ed25519 keypair to CoMakery. Keep the private key secure.
1. For test environments here you can store your api key and private key in your .env file at the root of the project

Copy the `.env.example` file to `.env` and enter these variables:
```
API_KEY=get this from CoMakery
PRIVATE_KEY=ed25519 private key
API_URL=https://www.comakery.com or your whitelable URL
```

## Making requests

Run the examples in the example folder against a test environment like this:
```
ruby examples/get_projects.rb
```

Or configure your own signed API requests like this:
```
Comakery::APISignature.signed_request(
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
                      "ethereum_wallet" => "0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B"}},
            "url" => API_ENDPOINT,
            "method" => "POST"
        }
    }
)
```

## Using the API

More complete documentation is here.

## Comakery::APISignature Library

Format of the request (JSON):
```json
{
  "body": {
    "data": {},
    "url": "https://example.org/",
    "method": "GET",
    "nonce": "ajgpe79rv6sv1i8sqhxobd",
    "timestamp": 1579539467614
  },
  "proof": {
    "type": "Ed25519Signature2018",
    "verificationMethod": "O7zTH4xHnD1jRKheBTrpNN24Fg1ddL8DHKi/zgVCVpA=",
    "signature": "FeDeSZNqfvz/EmfhIxz+tvRFXn83Xm0SUpcI/AJQDre0tGInJ96+/HN0nhG2vHPevKfpGaq9cr0zwuC6OEbvCQ=="
  }
}
```


### Example – Signing request:
```ruby
private_key = 'eodjQfDLTyNCBnz+MORHW0lOKWZnCTyPDTFcwAdVRyQ7vNMfjEecPWNEqF4FOuk03bgWDV10vwMcqL/OBUJWkA=='

request = {
  "body" => {
    "data" => {}
  }
}

signed_request = Comakery::APISignature.new(request).sign(private_key)
```


### Example – Verifying request:
```ruby
public_key = 'O7zTH4xHnD1jRKheBTrpNN24Fg1ddL8DHKi/zgVCVpA='

request = {
  "body" => {
    "data" => {},
    "url" => "https://example.org/",
    "method" => "GET",
    "nonce" =>"ajgpe79rv6sv1i8sqhxobd",
    "timestamp" => 1579539467614
  },
  "proof" => {
    "type" => "Ed25519Signature2018",
    "verificationMethod" => "O7zTH4xHnD1jRKheBTrpNN24Fg1ddL8DHKi/zgVCVpA=",
    "signature" => "FeDeSZNqfvz/EmfhIxz+tvRFXn83Xm0SUpcI/AJQDre0tGInJ96+/HN0nhG2vHPevKfpGaq9cr0zwuC6OEbvCQ=="
  }
}

is_nonce_unique = -> (nonce) { ['1', '2', '3'].none? nonce }
http_url = "https://example.org/"
http_method = "GET"

begin
  Comakery::APISignature.new(request, http_url, http_method, is_nonce_unique).verify(public_key)
rescue Comakery::APISignatureError => e
  e.message
end
```


Example – Usage in CLI:

`$ irb -r api_signature.rb -e 'puts Comakery::APISignature.new(File.read("request.json")).sign(File.read("key"))'`
`$ irb -r api_signature.rb -e 'puts Comakery::APISignature.new(File.read("request.json")).verify(File.read("key.pub"))'`