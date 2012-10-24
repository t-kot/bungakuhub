require 'spec_helper'

describe "repositories/new" do
  before(:each) do
    assign(:repository, stub_model(Repository,
      :type => "",
      :user_id => 1,
      :repository_type_id => 1,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
    @view.stub(:current_user).and_return(
      FactoryGirl.create(:user)
    )
  end

  it "renders new repository form" do
    render
  end
end
