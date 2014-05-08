class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
	skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  before_filter :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

	def create
    build_resource(sign_up_params)
    return confirm_account if resource.require_confirmation?
    if resource.save
      render json: {  status: "success", 
                      errors: "", 
                      data: { message: "Registered, Please confirm for login.",
                              email: resource.email,
                              auth_token: resource.authentication_token } }
    else
      render json: {  status: "failure", 
                      errors: resource.format_errors, 
                      data: { message: "Registration failed." } }
    end
  end

  protected

  def confirm_account
    render json: {  status: "success", 
                    errors: "", 
                    data: { message: "Already Registered, Please confirm for login.",
                            require_confirmation: true } }
  end 

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :date_of_birth) }
  end

end
