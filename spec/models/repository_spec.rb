#coding: utf-8
require 'spec_helper'
require 'grit'
require 'fileutils'

describe Repository do
  it "ownerはUserを返すこと" do
    repository = create(:repository)
    repository.owner.should be_an_instance_of(User)
    repository.owner.should_not be_nil
    repository.destroy
  end

  it "ownerに別のUserを代入できること" do
    repository = create(:repository)
    user = create(:user)
    repository.owner = user
    repository.owner.should == user
    repository.destroy
  end

  it "originalのとき" do
    repository = build(:repository, forked_from:nil)
    repository.original?.should == true
    repository.forked?.should == false
  end
  it "forkedのとき" do
    repository = build(:repository, forked_from:1)
    repository.original?.should == false
    repository.forked?.should == true
  end

  it "working_dirは文字列を返すこと" do
    repository = create(:repository, name:"WorkingDir")
    repository.working_dir.should == "#{Rails.root}/public/repositories/WorkingDir"
    repository.destroy
  end

  it "repoでGrit::Repoオブジェクトを得られること" do
    repository = create(:repository, name:"Repo1")
    repository.repo.should be_instance_of(Grit::Repo)
    repository.repo.should_not be_nil
    repository.destroy
  end

  it "git initでGrit::Repoオブジェクトを作成すること" do
    repository = build(:repository, name:"Repo2")
    repository.git_init.should be_instance_of(Grit::Repo)
    FileUtils.rm_r(repository.working_dir, {force:true})
  end

  it "mkdirで新しくディレクトリを作ること" do
    repository = build(:repository, name:"HOGEHOGEHOGE")
    lambda{ Dir.open(repository.working_dir) }.should raise_error(Errno::ENOENT)
    repository.mkdir
    dir = Dir.open(repository.working_dir)
    dir.should be_instance_of(Dir)
    dir.close
    Dir.rmdir(repository.working_dir)
  end

end
