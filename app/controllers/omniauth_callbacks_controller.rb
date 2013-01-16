#coding: utf-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(auth_hash)
    if @user
      p "ログイン"
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      if current_user
        p "連携"
        current_user.update_attributes(facebook_uid: auth_hash.uid)
        flash[:notice] = "認証を追加しました"
        redirect_to root_path
      else
        p "新規サインアップ"
        session["devise.facebook_data"] = auth_hash
        session["devise.facebook_uid"] = auth_hash.uid
        @user = User.new
        render 'devise/registrations/facebook'
      end
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth(auth_hash)
    if @user
      p "ログイン"
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "Twiter") if is_navigational_format?
    else
      if current_user
        current_user.update_attributes(twitter_uid: auth_hash.uid)
        flash[:notice] = "認証を追加しました"
        redirect_to root_path
      else
        p "新規サインアップ"
        session["devise.twitter_data"] = {uid: auth_hash.uid,
                             name: auth_hash.info.name}

        @user = User.new(display_name: auth_hash.info.name)
        render 'devise/registrations/twitter'
      end
    end
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
