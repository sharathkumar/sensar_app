class Users::SessionsController < Devise::SessionsController
	skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { :auth_token => current_user.authentication_token } }
  end

  def destroy
  	respond_to do |format|
  		format.json {
		    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
		    current_user.update_column(:authentication_token, nil)
		    render :status => 200,
		           :json => { :success => true,
		                      :info => "Logged out",
		                      :data => {} }
		  }
		  format.html { super }
	  end
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
end
