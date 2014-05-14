class Api::V1::SocialProfilesController < ApplicationController

	include ProfileManagement

	private

	def profile_params
		params.require(:social_profile ).permit(:user_id, :screen_name, :relationship_status, :discoverability, :personal_info, :carrier_status )
	end

end
