OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 184516511688959, '5f99f93f5b975a3b0e9df8da9567466f'
end