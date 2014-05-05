class Beacon

	def initialize
		@cms_connection = Faraday.new(:url => CMS_HOST) do |faraday|
											  faraday.request  :url_encoded             # form-encode POST params
											  faraday.response :logger                  # log requests to STDOUT
											  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
											end
	end

	def test
		response = @cms_connection.get '/j/cpgQPHVQQy?indent=4'     # GET http://sushi.com/nigiri/sake.json
		return JSON.parse(response.body)
	end

end