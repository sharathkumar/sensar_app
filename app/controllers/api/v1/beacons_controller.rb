class BeaconsController < ApplicationController
	layout 'success'
	
	def show
		@beacon = Beacon.find(params[:id])
	end

end
