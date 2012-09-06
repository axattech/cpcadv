ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "simple-earth-5502.herokuapp.com",
  :user_name            => "saroj.m@axat-tech.com",
  :password             => "rosogullasaroj",
  :authentication       => "plain",
  :enable_starttls_auto => true
}