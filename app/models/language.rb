class Language < ActiveRecord::Base
  attr_accessible :code, :name

  validates :name, uniqueness: true
end
