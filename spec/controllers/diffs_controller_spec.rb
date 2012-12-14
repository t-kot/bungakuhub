require 'spec_helper'

describe DiffsController do

  before(:each) do
    @user = create(:user)
    create_repository_for(@user)
    3.times{create_post_and_kommit_for(@repository.master)}
    @kommit1 = @repository.master.kommits[0]
    @kommit2 = @repository.master.kommits[1]
  end
  after do
    @repository.destroy
  end

  it "assigns kommits as @kommit1 and @kommit2" do
    get :show, {branch_id:@repository.master, kommit_id:@kommit1, id:@kommit2}
    assigns(:kommit1).should eq @kommit1
    assigns(:kommit2).should eq @kommit2
  end

  it "renders kommits/diff" do
    get :show, {branch_id:@repository.master, kommit_id:@kommit1, id:@kommit2}
    response.should render_template("kommits/diff")
  end

end
