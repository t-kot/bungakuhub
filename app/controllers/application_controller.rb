class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_locale

  def current_locale
    I18n.locale.to_s
  end
end
