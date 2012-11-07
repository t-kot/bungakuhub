class RepositoryType < ActiveRecord::Base
  attr_accessible :name
  serialize :name
  has_many :repositories

  validates :name, uniqueness: true
end
