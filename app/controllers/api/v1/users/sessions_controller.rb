class Api::V1::Users::SessionsController < Devise::SessionsController
  before_filter :ensure_params_exist, only: [:create]
  respond_to :json

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render status: 200,
           json:  { success: true,
                    info: "Logged in",
                    data: { auth_token: current_user.authentication_token } }
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    sign_out(resource_name)
    render status: 200,
           json: {  success: true,
                    info: "Logged out",
                    data: {} }
  end

  protected

  def ensure_params_exist
    return unless params[:user].blank?
    render  status: 422,  
            json: { success: false, 
                    info: "missing user login parameters" }
  end

  def failure
    render status: 401,
           json:  { success: false,
                    info: "Login Failed",
                    data: {} }
  end
end
