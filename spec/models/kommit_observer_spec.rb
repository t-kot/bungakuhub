require 'spec_helper'

describe KommitObserver do
  after(:each) do
    @repository.destroy
  end
  it "set correct revision" do
    @user = create(:user)
    create_repository_for(@user)
    @repository.master.posts.create({title:"hoge", body:"fuga"})
    @kommit = build(:kommit, message:"second")
    @kommit.user = @user
    @kommit.branches << @repository.master
    @kommit.init_at = @repository.master
    @kommit.save
    @repository.master.posts.create({title:"fuga", body:"piyo"})
    @kommit2 = build(:kommit, message:"third")
    @kommit2.branches << @repository.master
    @kommit2.init_at = @repository.master
    @kommit2.save

    Dir.chdir(@repository.working_dir) do
      output = `git rev-list master`
      newest_revision = output.split("\n").first

      newest_revision.should eq @kommit2.revision
    end
  end
end
