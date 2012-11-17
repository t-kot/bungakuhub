require 'spec_helper'

describe Post do
  pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @user = create(:user)
    create_repository_for(@user)
  end
  after(:each) do
    @repository.destroy
  end

  it "has file" do
    @post = @repository.master.posts.create({title:"Test", body:"Test"})
    File.open(@post.path).should be_an_instance_of(File)
  end

  it "can delete file" do
    @post = @repository.master.posts.create({title:"Test", body:"Test"})
    @post.delete_file
    lambda{ File.open(@post.path)}.should raise_error(Errno::ENOENT)
  end

  it "can remove index" do
    @post = @repository.master.posts.create({title:"Test", body:"Test"})
    @post.remove_index
    @repository.repo.status.untracked["Test.txt"].should_not be_nil
  end

end
