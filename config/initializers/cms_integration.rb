CMS_HOST = 'http://10.7.1.64:3000/'

CMS_CONNECTION = Faraday.new(:url => CMS_HOST) do |faraday|
										faraday.request  :url_encoded             # form-encode POST params
										faraday.response :logger                  # log requests to STDOUT
										faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
									end


AUTH_RESPONSE = CMS_CONNECTION.post do |req|
  req.url '/users/sign_in.json'
  req.headers['Content-Type'] = 'application/json'
  req.body = '{ "user": { "email": "admin@example.com", "password": "admin123" } }'
end

CMS_ACCESS_TOKEN = JSON.parse(AUTH_RESPONSE.body)["data"]["auth_token"]