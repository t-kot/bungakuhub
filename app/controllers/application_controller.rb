class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  helper_method :current_locale

  def current_locale
    I18n.locale.to_s
  end
  def set_locale
    session[:locale] = params[:locale] if params[:locale] && Language.all.map(&:code).index(params[:locale])
    I18n.locale = session[:locale] if session[:locale]
  end
end
