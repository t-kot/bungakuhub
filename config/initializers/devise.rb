Devise.setup do |config|
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.omniauth :facebook, "145038345651878", "738da90c8c0f6a791c8e88b187a2b9e9"
  config.omniauth :twitter, "0BLYypN8nZFgSKZYGebw", "2DpZdqdNOHdNJ1fa6kiYMoXiHKtIEZqK1GGHdtBalek"
end
