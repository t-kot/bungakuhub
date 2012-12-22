#coding: utf-8
class TextRepository < Repository
  attr_accessible :description, :name, :repository_type_id, :string, :text, :owner_id, :category_id
  belongs_to :user

  def type_name
    {"ja"=>"テキストレポジトリ", "en"=>"Text Repository"}
  end
end
