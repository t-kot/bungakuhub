#coding: utf-8
require 'spec_helper'

describe Sex do
  it "sexは３つ存在すること" do
    Sex.all.length.should == 3
  end
end
