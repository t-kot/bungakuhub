#require 'spec_helper'
#
#describe "kommits/index" do
#  before(:each) do
#    assign(:kommits, [
#      stub_model(Kommit,
#        :message => "Message",
#        :revision => "Revision"
#      ),
#      stub_model(Kommit,
#        :message => "Message",
#        :revision => "Revision"
#      )
#    ])
#  end
#
#  it "renders a list of kommits" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "Message".to_s, :count => 2
#    assert_select "tr>td", :text => "Revision".to_s, :count => 2
#  end
#end
