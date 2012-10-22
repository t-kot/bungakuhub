require 'spec_helper'

#describe "repositories/edit" do
#  before(:each) do
#    @repository = assign(:repository, stub_model(Repository,
#      :type => "",
#      :user_id => 1,
#      :repository_type_id => 1,
#      :name => "MyString",
#      :description => "MyText"
#    ))
#  end
#
#  it "renders the edit repository form" do
#    render
#
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "form", :action => repositories_path(@repository), :method => "post" do
#      assert_select "input#repository_type", :name => "repository[type]"
#      assert_select "input#repository_user_id", :name => "repository[user_id]"
#      assert_select "input#repository_repository_type_id", :name => "repository[repository_type_id]"
#      assert_select "input#repository_name", :name => "repository[name]"
#      assert_select "textarea#repository_description", :name => "repository[description]"
#    end
#  end
#end
