class Api::V1::SocialProfilesController < ApplicationController
	def create
		@social_profile = SocialProfile.new(social_profile_params)
		if @social_profile.save
			@message = "Social profile creation success."
		else
			@message = "Social profile creation failure."
			@errors = @social_profile.format_errors
		end
	end

	private

	def social_profile_params
		params.require(:social_profile ).permit(:user_id, :screen_name, :relationship_status, :discoverability, :personal_info, :carrier_status )
	end

end
