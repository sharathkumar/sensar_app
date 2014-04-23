class BeaconsController < ApplicationController
	layout 'success'
	respond_to :json
	def show
		@users = User.all
	end

end
