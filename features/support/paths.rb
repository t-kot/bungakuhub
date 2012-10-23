#coding: utf-8
module NavigationHelpers
  #Maps a name to a path.

  def path_to(page_name)
    case page_name

    when /トップページ/
      '/'
    when /ログインページ/
      new_user_session_path
    when /ユーザ登録ページ/
      new_user_registration_path
    when /テキストレポジトリ作成ページ/
      new_text_repository_path
    when /自分のプロフィール編集ページ/
      edit_user_path(@current_user)
    when /竹下登のプロフィール編集ページ/
      @user = User.find(2)
      edit_user_path(@user)
    else
      raise "\"#{page_name}\"にあたるpathが見当たりませんでした．"
    end
  end
end

World(NavigationHelpers)
