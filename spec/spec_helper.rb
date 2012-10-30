require 'simplecov'
SimpleCov.start 'rails'
require 'rubygems'
require 'spork'
require 'factory_girl_rails'
Spork.prefork do

end

Spork.each_run do
end
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
#require Rails.root.join('db/seeds')
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers,type: :controller
  config.extend ControllerMacros, type: :controller
end
