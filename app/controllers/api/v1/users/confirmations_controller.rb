class Users::ConfirmationsController < Devise::ConfirmationsController
	skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
	respond_to :json

	# GET /resource/confirmation?confirmation_token=abcdef
  def show
  	self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
    	render :status => 200,
       :json => { :success => true,
                  :info => "Your account was successfully confirmed., Please login.",
                  :data => {} }
    else
    	render :status => :unprocessable_entity,
       :json => { :success => false,
                  :info => resource.errors,
                  :data => {} }
    end
  end
  
end
