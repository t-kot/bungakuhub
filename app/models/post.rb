class Post < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :branch
  accepts_nested_attributes_for :branch
end
