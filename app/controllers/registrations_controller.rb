class RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user!, only:[:update]
  def new
    super
  end
  def create
    super
  end
  def update
    @user = current_user
    if current_user.update_with_password(params[:user])
      if is_navigational_format?
        if current_user.respond_to?(:pending_reconfirmation?) && current_user.pending_reconfirmation?
          flash_key = :update_needs_confirmation
        end
        set_flash_message :notice, flash_key || :updated
      end
      sign_in :user, current_user, :bypass => true
      respond_with current_user, :location => after_update_path_for(current_user)
    else
      clean_up_passwords current_user
      render '/users/edit'
    end
  end
end
