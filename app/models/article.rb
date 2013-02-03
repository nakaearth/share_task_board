class Article < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :descriptoin, :title
end
