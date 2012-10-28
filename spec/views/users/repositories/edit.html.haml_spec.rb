#require 'spec_helper'
#
#describe "users/repositories/edit" do
#  before(:each) do
#    @repository = assign(:repository, stub_model(Repository,
#      :type => "",
#      :user_id => 1,
#      :repository_type_id => 1,
#      :name => "MyString",
#      :description => "MyText"
#    ))
#    @view.stub(:current_user).and_return(
#      FactoryGirl.create(:user)
#    )
#    @view.stub(:current_locale).and_return("ja")
#  end
#
#  it "renders the edit repository form" do
#    render
#
#    assert_select "form", :action => user_repositories_path(@view.current_user, @repository), :method => "post" do
#      assert_select "input#repository_type", :name => "repository[type]"
#      assert_select "input#repository_user_id", :name => "repository[user_id]"
#      assert_select "input#repository_name", :name => "repository[name]"
#      assert_select "textarea#repository_description", :name => "repository[description]"
#    end
#  end
#end
