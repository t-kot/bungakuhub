class Repository < ActiveRecord::Base
  attr_accessible :description, :name, :repository_type_id, :type, :user_id
  belongs_to :repository_type
  belongs_to :user
  has_many :branches

  validates :name,  presence: true, length: {maximum:30}

  def owner
    self.user
  end
  def owner=(arg)
    self.user=(arg)
  end
  def original?
    self.forked_from.nil?
  end
  def forked?
    self.forked_from.present?
  end
end
