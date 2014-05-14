class BusinessProfile < ActiveRecord::Base
  validates :user_id, presence: true

  def format_errors
    errors.full_messages.join(" \n ")
  end
end
