require 'spec_helper'

describe Branch do
  before(:each) do
    @repository = create(:repository)
    create_post_and_kommit_for(@repository.master)
    
  end
  after(:each) do
    @repository.destroy
  end

  def create_another_branch
    @another = @repository.master.checkout(name:"another")
    @another.save
  end


  it "should be valid" do
    branch = @repository.branches.build(name: "develop")
    branch.should be_valid
  end
  it "should be invalid" do
    branch = @repository.branches.build(name: "")
    branch.should be_invalid
  end

  describe "destroyable?" do
    it "returns false" do
      @repository.master.destroyable?.should_not eq true
    end

    it "returns true" do
      create_another_branch
      @another.destroyable?.should eq true
    end
  end

  describe "checkout" do
    it "returns new branch object" do
      new_branch = @repository.master.checkout({name:"hoge"})
      new_branch.new_record?.should be_true
      new_branch.should be_an_instance_of(Branch)
    end

    it "has original branch" do
      new_branch = @repository.master.checkout(name:"hoge")
      new_branch.original_id.should eq @repository.master.id
    end
  end

  describe "original" do
    it "returns branch object" do
      new_branch = @repository.master.checkout(name:"hoge")
      new_branch.original.should eq @repository.master
    end
  end

  describe "rev_list" do
    it "returns array" do
      @repository.master.rev_list.should be_an_instance_of Array
    end
    it "increases count when commit added" do
      @repository.master.rev_list.should have(2).items
      create_post_and_kommit_for(@repository.master)
      @repository.master.rev_list.should have(3).items
    end
  end

  describe "destroy_all" do
    it "doesn't make callback work" do
      Post.any_instance.should_not_receive(:delete_file)
      @repository.master.destroy_all_post
    end
  end

  describe "nothing_to_commit" do
    it "return false" do
      create(:post, branch:@repository.master)
      @repository.master.nothing_to_commit?.should be_false
    end

    it "return true" do
      @repository.master.build_kommit(message:"commit1").save
      @repository.master.nothing_to_commit?.should be_true
    end

    context "another branch" do
      it "return true" do
        @repository.master.build_kommit(message:"commit1").save
        another = @repository.master.checkout(name:"another")
        another.save
        @repository.lock do
          @repository.checkout_to(another.name)
          create(:post, branch:another)
          @repository.checkout_master
        end
        @repository.master.nothing_to_commit?.should be_true
      end
      it "return false" do
        @repository.master.build_kommit(message:"commit1").save
        another = @repository.master.checkout(name:"another")
        another.save
        @repository.lock do
          @repository.checkout_to(another.name)
          create(:post, branch:another)
          @repository.checkout_master
        end
        another.nothing_to_commit?.should be_false
      end
    end
  end

  describe "merge" do
    before do
      create_another_branch
    end
    context "when merge succeeded" do
      context "no-conflicted" do
        before do
          2.times{create_post_and_kommit_for(@repository.master)}
          2.times{create_post_and_kommit_for(@another)}
        end
        it "returns merging branch " do
          @repository.master.merge(@another).should eq @repository.master
        end

        it "merging commit" do
          @repository.master.kommits.should have(4).items
          @repository.master.merge(@another)
          @repository.master.kommits.should have(5).items

        end
      end
      context "conflicted" do
        before do
          @repository.master.posts.first.body = "modify at master"
          @repository.master.posts.first.save
          @repository.master.build_kommit(message:"modify at master").save
          @another.posts.first.body = "modify at another"
          @another.posts.first.save
          @another.build_kommit(message:"modify at another").save
        end
        it "should not increase kommit count" do
          @repository.master.kommits.should have(3).items
          @repository.master.merge(@another)
          @repository.master.kommits.should have(3).items
        end
      end

    end
    context "when merge failed" do
      it "returns false if merged branch not commited" do
        create(:post, branch:@another)
        @repository.master.merge(@another).should be_false
      end
      it "returns false if merging branch not commited" do
        create(:post, branch:@another)
        @repository.master.merge(@another).should be_false
      end
    end
  end

  describe "git_branch_d" do
    before(:each) do
      create_another_branch
      @another.git_branch_d
    end

    it "should destroy git branch" do
      output = nil
      Dir.chdir(@another.repository.working_dir) do
        output = `git branch`
      end
    end
  end

end
