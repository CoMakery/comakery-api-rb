Implements signing and verifying Comkakery API requests with Ed25519 digital signature algorithm


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


Example – Signing request:
```ruby
private_key = 'eodjQfDLTyNCBnz+MORHW0lOKWZnCTyPDTFcwAdVRyQ7vNMfjEecPWNEqF4FOuk03bgWDV10vwMcqL/OBUJWkA=='

request = {
  "body" => {
    "data" => {}
  }
}

signed_request = Comakery::APISignature.new(request).sign(private_key)
```


Example – Verifying request:
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