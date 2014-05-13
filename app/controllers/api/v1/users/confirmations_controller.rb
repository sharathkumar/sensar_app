class Api::V1::Users::ConfirmationsController < Devise::ConfirmationsController
	skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
	respond_to :json

	# GET /resource/confirmation?confirmation_token=abcdef
  def show
  	self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
    	render json: {  status: "success",
                      errors: "",
                      data: { message: "Your account was successfully confirmed., Please login.",
                              email: resource.email,
                              auth_token: resource.authentication_token  } }
    else
    	render json: {  status: "failure",
                      errors: resource.format_errors,
                      data: { message: "Confirmation failed."} }
    end
  end

  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: {  status: "success",
                      errors: "",
                      data: { message: "You will receive an email with instructions about how to confirm your account in a few minutes." } }
    else
      render json: {  status: "failure",
                      errors: resource.format_errors,
                      data: { message: "Some errors occurred while processing." } }
    end
  end
  
end
