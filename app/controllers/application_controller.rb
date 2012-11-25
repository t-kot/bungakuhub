class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  helper_method :current_locale

  def user_repository_authenticate
    repository_id = params[:repository_id] || params[:id]
    unless current_user == Repository.find(repository_id).owner
      access_deny
    end
  end

  def user_branch_authenticate
    branch_id = params[:branch_id] || params[:id]
    unless current_user == Branch.find(branch_id).repository.owner
      access_deny
    end
  end

  def valid_user_authenticate
    user_id = params[:user_id] || params[:id]
    if current_user.try(:to_param) != user_id
      access_deny
    end
  end

  def current_locale
    I18n.locale.to_s
  end
  def set_locale
    session[:locale] = params[:locale] if params[:locale] && Language.all.map(&:code).index(params[:locale])
    I18n.locale = session[:locale] if session[:locale]
  end




  private
  def access_deny
    flash[:alert] = t("flash.alert.access_denied")
    redirect_to root_path
  end
  #def checkout_to(branch)
  #  repo = branch.repository.repo
  #  repository.lock do
  #    repo.create_stash
  #    repo.checkout_to(branch.name)
  #    repo.pop_first_at(branch.name)
  #  end
  #end

  #def checkout_master_from(branch)
  #  repo = branch.repository.repo
  #  repository.lock do
  #    repo.create_stash
  #    repo.checkout_to("master")
  #    repo.pop_first_at("master")
  #  end
  #end

end
