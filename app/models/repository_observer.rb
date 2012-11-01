class RepositoryObserver < ActiveRecord::Observer
  def before_create(repository)
    p repository.name
    Dir::mkdir("#{Rails.root}/public/repositories/#{repository.name}/")
    File.new("#{Rails.root}/public/repositories/#{repository.name}/README", "w")
  end
end
