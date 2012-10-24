require 'spec_helper'

describe "users/repositories/index" do
  before(:each) do
    @user = stub_model(User)
    assign(:repositories, [
      stub_model(Repository,
        :type => "",
        :user => @user,
        :repository_type_id => 2,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Repository,
        :type => "1",
        :user => @user,
        :repository_type_id => 2,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of repositories" do
    render
    #assert_select "tr>td", :text => "TextRepository".to_s, :count => 2
    #assert_select "tr>td", :text => @user.to_s, :count => 2
    #assert_select "tr>td", :text => @user.to_s, :count => 2
    #assert_select "tr>td", :text => "Name".to_s, :count => 2
    #assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
