OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  FACEBOOK_APP_ID = "522372217880464"
  FACEBOOK_SECRET = "b6af9ba9544a961b0a13b8f14ddf36bf"
  provider :facebook, FACEBOOK_APP_ID, FACEBOOK_SECRET, {:scope => "create_event"} # to add more permissions, add them to the scope
end