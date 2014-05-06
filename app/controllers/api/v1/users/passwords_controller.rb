class Api::V1::Users::PasswordsController < Devise::PasswordsController

	# POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      render  json: { status: "success",
                  	  errors: "",
                  	  data: { message: "You will receive an email with instructions on how to reset your password in a few minutes." } }
    else
      render  json: { status: "failure",
                  	  errors: resource.format_errors,
                  	  data: { message: "Some errors occurred while processing." } }
    end
  end

	 # PUT /resource/password
  def update
		self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render  json: { status: "success",
                      errors: "",
                      data: { message: "Your password was changed successfully." } }
    else
      render  json: { status: "failure",
                      errors: resource.format_errors,
                      data: { message: "Some errors occurred while processing." } }
    end
  end

end
