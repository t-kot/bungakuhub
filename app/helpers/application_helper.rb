module ApplicationHelper
  def is_active?(*page)
    "active" if page.include? "#{params[:controller]}##{params[:action]}"
  end
end
