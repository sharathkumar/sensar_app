class Api::V1::Users::SessionsController < Devise::SessionsController
  before_filter :ensure_params_exist, only: [:create]
  respond_to :json

  def create
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource
    return is_confirmed_resource if resource.confirmed_at == nil
    if resource.valid_password?(params[:user][:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token
      render json: {  status: "success", 
                      errors: "", 
                      data: { message: "Logged in",
                              auth_token: resource.authentication_token, 
                              email: resource.email } }
      return
    end
    invalid_login_attempt
  end

  def destroy
    resource = User.find_for_database_authentication(:email => params[:email])
    resource.authentication_token = nil
    resource.save
    render :json=> {  status: "success",
                      errors: "",
                      data: { message: "Logged out" } }
  end

  protected

  def invalid_login_attempt
    render json: {  status: "failure", 
                    errors: "",
                    data: { message: "Invalid login or password" } }
  end

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {  status: "failure", 
                    errors: "", 
                    data: { message: "missing user login parameters" } }
  end

  def is_confirmed_resource
    render json: {  status: "failure", 
                    errors: "", 
                    data: { message: "You have to confirm your account before continuing.", 
                            require_confirm: true } }
  end

end
