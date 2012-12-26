#coding: utf-8
require 'spec_helper'

describe AlphaNumericValidator do
  before do
    @validator = AlphaNumericValidator.new({attributes: {}} )
    @mock = mock('model')
    @mock.stub_chain(:errors, "[]", "<<")
  end

  it "should validate valid value(1)" do
    @mock.should_not_receive("errors")
    @validator.validate_each(@mock, "name", "abcdefd12a")
  end

  it "should validate valid value(2)" do
    @mock.should_not_receive("errors")
    @validator.validate_each(@mock, "name", "112341345132414234")
  end

  it "should validate invalid value(1)" do
    @mock.errors[].should_receive("<<")
    @validator.validate_each(@mock, "name", "てすと")
  end

  it "should validate invalid value(2)" do
    @mock.errors[].should_receive("<<")
    @validator.validate_each(@mock, "name", "test><")
  end

  it "should validate invalid value(3)" do
    @mock.errors[].should_receive("<<")
    @validator.validate_each(@mock, "name", "test test")
  end
end
