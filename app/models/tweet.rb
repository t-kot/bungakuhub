class Tweet < Feed
  attr_accessible :body
  belongs_to :user


end
