class Post < ActiveRecord::Base
  attr_accessor :delete, :skip_callback
  attr_accessible :body, :title, :delete, :skip_callback
  belongs_to :branch

  def delete_file
    repository = post.branch.repository
    File.unlink("#{repository.working_dir}/#{self.title}.txt")
  end

  def remove_index
    repository = post.branch.repository
    repository.repo.remove("#{self.title}.txt")
  end
end
