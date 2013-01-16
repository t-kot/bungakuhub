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

  def facebook
    @user = User.new_with_facebook_session(params[:user], session)
    if @user.save
      @user.confirm!
      set_flash_message :notice, :signed_up if is_navigational_format?
      sign_in_and_redirect @user
    else
      render 'devise/registrations/facebook'
    end
  end

  def twitter
    @user = User.new_with_twitter_session(params[:user], session)
    if @user.save
      set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
      expire_session_data_after_sign_in!
      respond_with @user, location: after_inactive_sign_up_path_for(@user)
    else
      render 'devise/registrations/twitter'
    end
  end
end
