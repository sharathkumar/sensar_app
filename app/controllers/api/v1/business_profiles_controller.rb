class Api::V1::BusinessProfilesController < ApplicationController
  include ProfileManagement

  private

  def profile_params
    params.require(:business_profile ).permit(:user_id, :business_name, :skills, :discoverability, :business_info, :website )
  end

end
