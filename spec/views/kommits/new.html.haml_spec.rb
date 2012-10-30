#require 'spec_helper'
#
#describe "kommits/new" do
#  before(:each) do
#    assign(:kommit, stub_model(Kommit,
#      :message => "MyString",
#      :revision => "MyString"
#    ).as_new_record)
#  end
#
#  it "renders new kommit form" do
#    render
#
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "form", :action => kommits_path, :method => "post" do
#      assert_select "input#kommit_message", :name => "kommit[message]"
#      assert_select "input#kommit_revision", :name => "kommit[revision]"
#    end
#  end
#end
