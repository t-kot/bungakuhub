#coding: utf-8
require 'spec_helper'

describe Sex do
  it "has 3 records" do
    Sex.all.length.should == 3
  end
end
