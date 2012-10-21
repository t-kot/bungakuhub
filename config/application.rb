require File.expand_path('../boot', __FILE__)
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"
require "sprockets/railtie"
if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Bungaku
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.active_record.whitelist_attributes = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.i18n.default_locale = :ja
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/validators)
    config.i18n.load_path += Dir[Rails.root.join('config', 'locale', '**', '*.{rb,yml}')]
  end
end
