require 'spec_helper'

#describe "repositories/index" do
#  before(:each) do
#    assign(:repositories, [
#      stub_model(Repository,
#        :type => "Type",
#        :user_id => 1,
#        :repository_type_id => 2,
#        :name => "Name",
#        :description => "MyText"
#      ),
#      stub_model(Repository,
#        :type => "Type",
#        :user_id => 1,
#        :repository_type_id => 2,
#        :name => "Name",
#        :description => "MyText"
#      )
#    ])
#  end
#
#  it "renders a list of repositories" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Type".to_s, :count => 2
#    assert_select "tr>td", :text => 1.to_s, :count => 2
#    assert_select "tr>td", :text => 2.to_s, :count => 2
#    assert_select "tr>td", :text => "Name".to_s, :count => 2
#    assert_select "tr>td", :text => "MyText".to_s, :count => 2
#  end
#end
