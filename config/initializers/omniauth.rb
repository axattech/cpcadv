OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '321602951263082', '1bff70d32f3e9adcf585d5776ca07f96',
           :display => 'popup'
  provider :twitter, "waDN2wyvsHDeV68Nwhv6MA", "IVcHmMWZvtgGey0gdUIAauWTl2f8gtOzVywvsze0", 
           :display => 'popup'
end