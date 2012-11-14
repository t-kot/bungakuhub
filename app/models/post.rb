class Post < ActiveRecord::Base
  attr_accessor :delete, :skip_callback
  attr_accessible :body, :title, :delete, :skip_callback
  belongs_to :branch
end
