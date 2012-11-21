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
      File.rename("#{repository.working_dir}/#{post.title_was}.txt", "#{repository.working_dir}/#{post.title}.txt")
      repository.repo.remove("#{post.title_was}.txt")
      update_file = open("#{repository.working_dir}/#{post.title}.txt", "w"){|f| f.write(post.body)}
    else
      update_file = open("#{repository.working_dir}/#{post.title}.txt", "w"){|f| f.write(post.body)}
    end
    blob = Grit::Blob.create(repository.repo, {name:"#{post.title}.txt", data: update_file})
    Dir.chdir(repository.repo.working_dir){repository.repo.add(blob.name)}
  end

  def after_update(post)
    return if post.bare
  end

  def before_destroy(post)
    return if post.bare
    post.delete_file
    post.remove_index
  end

  private
  def add_index(post)
    repository = post.branch.repository
    new_file = open("#{repository.working_dir}/#{post.title}.txt", "w"){|f| f.write(post.body)}
    new_blob = Grit::Blob.create(repository.repo, {name:"#{post.title}.txt", data:new_file})
    Dir.chdir(repository.repo.working_dir){repository.repo.add(new_blob.name)}
  end

end
