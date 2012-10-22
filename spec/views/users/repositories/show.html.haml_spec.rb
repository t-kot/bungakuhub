require 'spec_helper'

describe "users/repositories/show" do
  before(:each) do
    @repository = assign(:repository, stub_model(Repository,
      :type => "Type",
      :user_id => 1,
      :repository_type_id => 2,
      :name => "Name",
      :description => "MyText"
    ))
    @view.stub(:current_user).and_return(
      FactoryGirl.create(:tanaka)
    )
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Type/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
