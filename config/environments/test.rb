Bungaku::Application.configure do
  config.cache_classes = true
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection    = false
  config.active_record.mass_assignment_sanitizer = :strict
  config.active_support.deprecation = :stderr
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = {host:'localhost:3000'}
  #config.action_mailer.smtp_settings = {
  #  :enable_starttls_auto =>true,
  #  :address => 'smtp.gmail.com',
  #  :port => 587,
  #  :domain => 'gmail.com',
  #  :authentication => :plain,
  #  :user_name => 'bungakuhub',
  #  :password => 'mishimayukio'
  #}
end
