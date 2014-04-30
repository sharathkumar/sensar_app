class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  	skip_before_filter :verify_authenticity_token,
                       :if => Proc.new { |c| c.request.format == 'application/json' }
    before_filter :configure_permitted_parameters, if: :devise_controller?

    respond_to :json

  	def create
      build_resource(sign_up_params)
      # resource.skip_confirmation!
      if resource.save
        # sign_in resource
        render :status => 200,
             :json => { :success => true,
                        :info => "Registered, Please confirm for login.",
                        :data => { :user => resource,
                                   :auth_token => resource.authentication_token } }
      else
        render :status => :unprocessable_entity,
               :json => { :success => false,
                          :info => resource.errors,
                          :data => {} }
      end
    end

    protected

    def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :date_of_birth) }
    end

end
