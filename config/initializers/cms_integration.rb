CMS_HOST = 'http://10.7.1.17:4000/'

CMS_CONNECTION = Faraday.new(:url => CMS_HOST) do |faraday|
										faraday.request  :url_encoded             # form-encode POST params
										faraday.response :logger                  # log requests to STDOUT
										faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
									end
CMS_CONNECTION.basic_auth('admin@example.com', 'admin123')
