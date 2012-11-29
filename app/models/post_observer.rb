class PostObserver < ActiveRecord::Observer
  def after_create(post)
    return if post.bare
    post.add_index
  end

  def before_update(post)
    return if post.bare
    return unless post.changed?
    post.rename if post.title_changed?
    post.add_index
  end

  def after_update(post)
    return if post.bare
  end

  def before_destroy(post)
    return if post.bare
    post.delete_file
    ##TODO commitされている場合に外す処理は下でよいが、commitされずにステージされているものを削除するにはcheckoutしないといけない
    post.remove_index
  end


end
