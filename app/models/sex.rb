class Sex < ActiveRecord::Base
  attr_accessible :name
  serialize :name
end
