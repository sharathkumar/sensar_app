class Api::V1::Users::SessionsController < Devise::SessionsController
  before_filter :ensure_params_exist, only: [:create]
  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource
    return not_confirmed(resource) if resource.require_confirmation?
    if resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token
      render json: {  status: "success", 
                      errors: "", 
                      data: { message: "Logged in",
                              auth_token: resource.authentication_token, 
                              email: resource.email,
                              require_confirm: "NO" } }
      return
    end
    invalid_login_attempt
  end

  def destroy
    resource = User.find_for_database_authentication(:authentication_token => params[:auth_token])
    if resource
      resource.authentication_token = nil
      resource.save
      render :json=> {  status: "success",
                        errors: "",
                        data: { message: "Logged out" } }
    else
      render json: {  status: "failure", 
                      errors: "You need to sign in before continue.",
                      data: { message: "Logout failed" } }
    end
    
  end

  protected

  def invalid_login_attempt
    render json: {  status: "failure", 
                    errors: "Invalid login or password",
                    data: { message: "Login failed",
                            require_confirm: "NO" } }
  end

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {  status: "failure", 
                    errors: "missing user login parameters", 
                    data: { message: "Login failed",
                            require_confirm: "NO" } }
  end

  def not_confirmed(resource)
    render json: {  status: "success", 
                    errors: "You have to confirm your account before continuing.", 
                    data: { message: "Login failed", 
                            email: resource.email,
                            require_confirm: "YES" } }
  end

end
