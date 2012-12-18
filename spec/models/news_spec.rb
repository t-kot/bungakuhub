require 'spec_helper'

describe News do

  it "cannot create because News is abstract class" do
    lambda{News.create}.should raise_error
  end

end
