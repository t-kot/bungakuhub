#require 'spec_helper'
#
#describe "users/text_repositories/index" do
#  before(:each) do
#    current_user = User.new(display_name:"hoge",email:"hoge@fuga.com", password:"testtest")
#    assign(:text_repositories, [
#      stub_model(TextRepository,
#        :user_id => 1,
#        :user => mock_model(User),
#        :repository_type_id => 1,
#        :name => "Name",
#        :description => "Description",
#      ),
#      stub_model(TextRepository,
#        :user_id => 2,
#        :user => mock_model(User),
#        :repository_type_id => 1,
#        :name => "Name",
#        :description => "Description",
#      )
#    ])
#    @view.stub(:current_user).and_return(current_user)
#    @view.stub(:current_locale).and_return("ja")
#  end
#
#  it "renders a list of text_repositories" do
#    render
#    #assert_select "tr>td", :text => 1.to_s, :count => 2
#    #assert_select "tr>td", :text => "Repository Type".to_s, :count => 2
#    assert_select "tr>td", :text => "Name".to_s, :count => 2
#    assert_select "tr>td", :text => "Description".to_s, :count => 2
#  end
#end
