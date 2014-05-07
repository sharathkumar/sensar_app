class Api::V1::BeaconsController < ApplicationController
	layout 'success'
	
	def show
		beacon_response = Beacon.new
		render json: beacon_response.details(params[:beacon_id])
	end

end
