require 'spec_helper'

describe DiffsController do

  let(:repository){mock_model(Repository, id:1).as_null_object}
  let(:kommit1){mock_model(Kommit, id:1, repository:repository).as_null_object}
  let(:kommit2){mock_model(Kommit, id:2).as_null_object}

  before do
    Kommit.stub(:find).with("1").and_return(kommit1)
    Kommit.stub(:find).with("2").and_return(kommit2)
  end
  it "assigns kommits as @kommit1 and @kommit2" do
    get :show, {branch_id:1, kommit_id:kommit1, id:kommit2}
    assigns(:kommit1).should eq kommit1
    assigns(:kommit2).should eq kommit2
  end

  it "renders kommits/diff" do
    get :show, {branch_id:1, kommit_id:kommit1, id:kommit2}
    response.should render_template("kommits/diff")
  end

  context "when no diff found" do
    before do
      repository.stub_chain(:repo, :diff).and_return nil
    end

    it "raise BungakuHub::GitError" do
      expect{
        get :show, {branch_id:1, kommit_id:kommit1, id:kommit2}
      }.to raise_error(BungakuHub::GitError)
    end
  end

end
