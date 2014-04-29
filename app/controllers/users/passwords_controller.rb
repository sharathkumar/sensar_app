class Users::PasswordsController < Devise::PasswordsController

	# POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render :status => 200,
       	:json => { 	:success => true,
                  	:info => "You will receive an email with instructions on how to reset your password in a few minutes.",
                  	:data => {} }
    else
      render :status => :unprocessable_entity,
       	:json => { 	:success => false,
                  	:info => resource.errors,
                  	:data => {} }
    end
  end

	 # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      render :status => 200,
       	:json => { :success => true,
                  :info => "Your password was changed successfully.",
                  :data => {} }
    else
      render :status => :unprocessable_entity,
       	:json => { :success => false,
                  :info => resource.errors,
                  :data => {} }
    end
  end

end
