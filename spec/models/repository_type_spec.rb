#coding: utf-8
require 'spec_helper'

describe RepositoryType do
  it "typeは２つ存在すること" do
    RepositoryType.all.length.should == 2
  end
end
