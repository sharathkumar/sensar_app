class Api::V1::BeaconsController < ApplicationController
	layout 'success'

	def show
		beacon = Beacon.new
		param_hash = beacon.params_hash(params)
		return params_missing_error if param_hash.values.any? &:nil?
		begin
			render json: beacon.details(param_hash)
		rescue Exception => e
			server_error
		end
	end

	private

	def params_missing_error
		render :json=> {  status: "failure",
	                    				errors: "Some params are missing.",
	                    				data: { message: "Please check all params." } }
	end

	def server_error
		render :json=> {  status: "failure",
                      				errors: "Failed to fetch data.",
                      				data: { message: "Please try again later." } }
	end

end
