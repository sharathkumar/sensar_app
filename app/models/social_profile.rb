class SocialProfile < ActiveRecord::Base

  def format_errors
    errors.full_messages.join(" \n ")
  end
end
