class Category < ActiveRecord::Base
  serialize :name
  attr_accessible :name, :type
  has_many :repositories

  validates :name, uniqueness: true
end
