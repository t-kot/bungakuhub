require 'spec_helper'

#describe "text_repositories/index" do
#  before(:each) do
#    assign(:text_repositories, [
#      stub_model(TextRepository,
#        :user_id => 1,
#        :repository_type_id => "Repository Type",
#        :integer => "Integer",
#        :name => "Name",
#        :string => "String",
#        :description => "Description",
#        :text => "Text"
#      ),
#      stub_model(TextRepository,
#        :user_id => 1,
#        :repository_type_id => "Repository Type",
#        :integer => "Integer",
#        :name => "Name",
#        :string => "String",
#        :description => "Description",
#        :text => "Text"
#      )
#    ])
#  end
#
#  it "renders a list of text_repositories" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => 1.to_s, :count => 2
#    assert_select "tr>td", :text => "Repository Type".to_s, :count => 2
#    assert_select "tr>td", :text => "Integer".to_s, :count => 2
#    assert_select "tr>td", :text => "Name".to_s, :count => 2
#    assert_select "tr>td", :text => "String".to_s, :count => 2
#    assert_select "tr>td", :text => "Description".to_s, :count => 2
#    assert_select "tr>td", :text => "Text".to_s, :count => 2
#  end
#end
