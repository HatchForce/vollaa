OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 184516511688959, '5f99f93f5b975a3b0e9df8da9567466f'
  provider :twitter, 'MEYDOtnrXMYK5yF3yo1kmQ', 'h9nzW0juvFRKdcGAmu9TqWoY7URf01hE4CH0XLlMo'
end