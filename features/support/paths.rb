#coding: utf-8
module NavigationHelpers
  #Maps a name to a path.

  def path_to(page_name)
    case page_name

    when /トップページ/
      '/'
    when /ログインページ/
      new_user_session_path
    else
      raise "\"#{page_name}\"にあたるpathが見当たりませんでした．"
    end
  end
end

World(NavigationHelpers)
