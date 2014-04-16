ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "gmail.com",  
  :user_name            => "sensarqb@gmail.com",  
  :password             => "sensar@qb",  
  :authentication       => "plain"
  # :enable_starttls_auto => true # I don't have this, but it should work anyway 
} 