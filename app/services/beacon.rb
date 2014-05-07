class Beacon

	def details(beacon_id)
		response = CMS_CONNECTION.get "/beacons/#{beacon_id}.json", {auth_token: CMS_ACCESS_TOKEN }     # GET http://sushi.com/nigiri/sake.json
		return JSON.parse(response.body)
	end

end