#coding: utf-8
require 'spec_helper'

describe Language do
  it "言語は２つ存在すること" do
    Language.all.length.should == 2
    #Language.should have(2).all
  end
end
