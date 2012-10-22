require 'spec_helper'

#describe "text_repositories/edit" do
#  before(:each) do
#    @text_repository = assign(:text_repository, stub_model(TextRepository,
#      :user_id => 1,
#      :repository_type_id => "MyString",
#      :integer => "MyString",
#      :name => "MyString",
#      :string => "MyString",
#      :description => "MyString",
#      :text => "MyString"
#    ))
#  end
#
#  it "renders the edit text_repository form" do
#    render
#
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "form", :action => text_repositories_path(@text_repository), :method => "post" do
#      assert_select "input#text_repository_user_id", :name => "text_repository[user_id]"
#      assert_select "input#text_repository_repository_type_id", :name => "text_repository[repository_type_id]"
#      assert_select "input#text_repository_integer", :name => "text_repository[integer]"
#      assert_select "input#text_repository_name", :name => "text_repository[name]"
#      assert_select "input#text_repository_string", :name => "text_repository[string]"
#      assert_select "input#text_repository_description", :name => "text_repository[description]"
#      assert_select "input#text_repository_text", :name => "text_repository[text]"
#    end
#  end
#end
