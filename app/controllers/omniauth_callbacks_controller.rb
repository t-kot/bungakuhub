#coding: utf-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(auth_hash)
    if @user
      p "ログイン"
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      @user = User.find_by_email(auth_hash.info.email)
      if @user
        p "連携"
        @user.update_attributes(facebook_uid: auth_hash.uid)
        sign_in_and_redirect @user
        flash[:notice] = "認証を追加しました"
      else
        p "新規サインアップ"
        session["devise.facebook_data"] = auth_hash
        session["facebook_uid"] = auth_hash.uid
        @user = User.new
        render 'devise/registrations/facebook'
      end
    end
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end
