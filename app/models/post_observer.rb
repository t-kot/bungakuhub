class PostObserver < ActiveRecord::Observer
  def after_create(post)
    return if post.bare
    add_index(post)
  end

  def before_update(post)
    return if post.bare
    return unless post.changed?
    repository = post.branch.repository
    if post.title_changed?
      File.rename("#{repository.working_dir}/#{post.title_was}", "#{repository.working_dir}/#{post.title}")
      repository.repo.remove("#{post.title_was}")
      update_file = open("#{repository.working_dir}/#{post.title}", "w"){|f| f.write(post.body)}
    else
      update_file = open("#{repository.working_dir}/#{post.title}", "w"){|f| f.write(post.body)}
    end
    blob = Grit::Blob.create(repository.repo, {name:"#{post.title}", data: update_file})
    Dir.chdir(repository.repo.working_dir){repository.repo.add(blob.name)}
    #Dir.chdir(repository.working_dir) do
    #  system(%Q[git add "#{blob.name}"])
    #end
  end

  def after_update(post)
    return if post.bare
  end

  def before_destroy(post)
    return if post.bare
    post.delete_file
    ##TODO commitされている場合に外す処理は下でよいが、commitされずにステージされているものを削除するにはcheckoutしないといけない
    post.remove_index
    #remove_index(post)
  end

  private
  def add_index(post)
    repository = post.branch.repository
    #Dir.chdir(repository.working_dir) do
    #  system(%Q[git add "#{post.title}"])
    #end
    new_file = open(post.path, "w"){|f| f.write(post.body)}
    new_blob = Grit::Blob.create(repository.repo, {name:"#{post.title}", data:new_file})
    Dir.chdir(repository.repo.working_dir){repository.repo.add(new_blob.name)}
  end

  #def remove_index(post)
  #  repository = post.branch.repository
  #  Dir.chdir(repository.working_dir) do
  #    system(%Q[git rm "#{post.title}"])
  #  end
  #end

end
