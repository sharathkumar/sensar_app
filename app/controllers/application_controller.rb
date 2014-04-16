class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :authenticate_user_from_token!
  # before_filter :after_token_authentication
  before_action :authenticate_user!

  def after_token_authentication
    if params[:authentication_key].present?
      @user = User.find_by_authentication_token(params[:authentication_key]) # we are finding 
      the user with the authentication_key with which devise has authenticated the user
      sign_in @user if @user # we are siging in user if it exist. sign_in is devise method to sigin in any user
      redirect_to root_path # now we are redirecting the user to root_path i,e our home page
    end
  end

  # For this example, we are simply using token authentication
	# via parameters. However, anyone could use Rails's token
	# authentication features to get the token from a header.
	def authenticate_user_from_token!
		p "sssssssssssssssssssssssssssssssssssssssss"
		user_token = params[:auth_token].presence
		user = user_token && User.find_by_authentication_token(user_token.to_s)
		 
		if user
			# Notice we are passing store false, so the user is not
			# actually stored in the session and a token is needed
			# for every request. If you want the token to work as a
			# sign in token, you can simply remove store: false.
			sign_in user, store: false
		end
	end

	# def authenticate_user_from_token!
	# 	user_email = params[:user_email].presence
	# 	user = user_email && User.find_by_email(user_email)
		 
	# 	# Notice how we use Devise.secure_compare to compare the token
	# 	# in the database with the token given in the params, mitigating
	# 	# timing attacks.
	# 	if user && Devise.secure_compare(user.authentication_token, params[:user_token])
	# 	sign_in user, store: false
	# 	end
	# end

end
