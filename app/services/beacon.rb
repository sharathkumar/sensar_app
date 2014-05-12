class Beacon

	PARAMS = ["proximity_uuid", "major_id", "minor_id"]

	def details(params)
		response = 	CMS_CONNECTION.post do |req|  # GET http://sushi.com/nigiri/sake.json
									req.url "/beacon_details.json"
								  req.headers['Content-Type'] = 'application/json'
								  req.body = params.to_json
								end
		return JSON.parse(response.body)
	end

	def params_hash(params)
		PARAMS.each_with_object({}) {|attr, hash| hash[attr] = params[:beacon][attr] }
	end

end