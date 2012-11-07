require 'fileutils'
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

  def mkdir
    Dir::mkdir("#{Rails.root}/public/repositories/#{self.name}/")
  end
  def init_readme
    FileUtils.cp("#{Rails.root}/lib/public/README.rdoc",
                 "#{Rails.root}/public/repositories/#{self.name}/README_template.rdoc")
  end
end
