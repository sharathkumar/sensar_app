class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

 	UPDATE_ATTRS = ["password", "password_confirmation", "first_name", "last_name", "date_of_birth"]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_save :ensure_authentication_token

  def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	def format_errors
		errors.full_messages.join(" \n ")
	end
	
	def require_confirmation?
		user = User.find_by_email(email)
		if user && user.confirmed_at == nil
			user.update_me
			return true
		else
			return false
		end 
	end

	def update_me
		update_attributes(update_attrs)
	end

	def update_attrs
		UPDATE_ATTRS.each_with_object({}) {|attr, hash| hash[attr] = send(attr) }
	end

	private

	def generate_authentication_token
		loop do
			token = Devise.friendly_token
			break token unless User.where(authentication_token: token).first
		end
	end

end
