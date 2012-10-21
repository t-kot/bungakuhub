class Sex < ActiveRecord::Base
  attr_accessible :name
  serialize :name

  has_many :users
end
