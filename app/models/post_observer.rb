class PostObserver < ActiveRecord::Observer
  def after_create(post)
    repository = post.branch.repository
    new_file = open("#{repository.working_dir}/#{post.title}.txt", "w"){|f| f.write(post.body)}
    new_blob = Grit::Blob.create(repository.repo, {name:"#{post.title}.txt", data:new_file})
    Dir.chdir(repository.repo.working_dir){repository.repo.add(new_blob.name)}
  end

  def after_update(post)
    repository = post.branch.repository
    update_file = open("#{repository.working_dir}/#{post.title}.txt", "w"){|f| f.write(post.body)}
    blob = repository.repo.tree / "#{post.title}.txt"
    Dir.chdir(repository.repo.working_dir){repository.repo.add(blob.name)}
  end

  def before_destroy(post)
    repository = post.branch.repository
    File.unlink("#{repository.working_dir}/#{post.title}.txt")
    repository.repo.remove("#{post.title}.txt")
  end
end
