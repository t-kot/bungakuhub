require 'spec_helper'

describe Category do
  it "returns all categories" do
    Category.all.length.should == TextCategory.all.length
  end
end
