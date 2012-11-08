class Post < ActiveRecord::Base
  attr_accessor :delete
  attr_accessible :body, :title, :delete
  belongs_to :branch
end
