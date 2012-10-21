# coding: utf-8
require 'spec_helper'

describe 'email_validator' do
  before do
    @validator = EmailValidator.new({attributes: {}})
    @mock = mock('model')
    @mock.stub("errors").and_return([])
    @mock.errors.stub('[]').and_return({})
    @mock.errors[].stub('<<')
  end
  it '許可' do
    @mock.should_not_receive('errors')
    @validator.validate_each(@mock, "email", "test@test.com")
    @validator.validate_each(@mock, "email", "t.kotohata@test.com")
  end
  it "should validate invalid address" do
    @mock.errors[].should_receive('<<')
    @validator.validate_each(@mock, "email", "notvalid")
    @validator.validate_each(@mock, "email", "asdf1234@america")
  end
end
