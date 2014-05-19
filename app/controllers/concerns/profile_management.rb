module ProfileManagement
  extend ActiveSupport::Concern

  included do
    before_filter :set_profile_model
  end

  def create
    @profile = @model_name.new(profile_params)
    if @profile.save
      @message = "Profile creation success."
    else
      @message = "Profile creation failed."
      @errors = @profile.format_errors
    end
  end

  def update
    @profile = @model_name.update(params[:id], profile_params)
    if @profile.errors.empty?
      @message = "Profile updation success."
    else
      @message = "Profile updation failed."
      @errors = @profile.format_errors
    end
  end

  def delete
    @profile = @model_name.find(params[:id])
    if @profile.destroy
      @message = "Profile deleted."
    else
      @message = "Profile deletion failed."
      @errors = @profile.format_errors
    end
  end

  def show
    @profile = @model_name.find(params[:id])
    @message = ""
  end

  def set_profile_model
    @model_name = controller_name.classify.constantize
  end

end
