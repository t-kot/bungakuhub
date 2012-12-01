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
    when /^(.*)のテキストレポジトリ作成ページ/
      @user = User.find_by_display_name($1)
      new_user_text_repository_path(@user)
    when /自分のプロフィール編集ページ/
      edit_user_path(@current_user)
    when /^(.*)のプロフィール編集ページ$/
      @user = User.find_by_display_name($1)
      edit_user_path(@user)
    when /レポジトリ管理ページ$/
      admin_repositories_path
    when /^(.*)のレポジトリ詳細ページ$/
      repo = Repository.find_by_name($1)
      admin_repository_path(repo)
    when /^(.*)のレポジトリ編集ページ$/
      repo = Repository.find_by_name($1)
      edit_admin_repository_path(repo)
    when /^(.*)の(.*)ブランチのチェックアウト作成ページ$/
      branch = Repository.find_by_name($1).branches.find_by_name($2)
      new_admin_branch_checkout_path(branch)
    when /^(.*)の(.*)ブランチのコミット作成ページ$/
      branch = Repository.find_by_name($1).branches.find_by_name($2)
      new_admin_branch_kommit_path(branch)
    when /^(.*)の(.*)ブランチのポスト一覧ページ$/
      branch = Repository.find_by_name($1).branches.find_by_name($2)
      admin_branch_posts_path(branch)
    when /^(.*)の(.*)ブランチのマージ作成ページ$/
      branch = Repository.find_by_name($1).branches.find_by_name($2)
      new_admin_branch_merge_path(branch)
    when /^(.*)の(.*)ブランチのコミット一覧ページ$/
      branch = Repository.find_by_name($1).branches.find_by_name($2)
      branch_kommits_path(branch)
    else
      raise "\"#{page_name}\"にあたるpathが見当たりませんでした．"
    end
  end
end

World(NavigationHelpers)
