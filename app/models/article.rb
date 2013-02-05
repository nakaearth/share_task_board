class Article < ActiveRecord::Base
  belongs_to :blog
  #attr_accessible :descriptoin, :title
  
  validates :title, :presence => true, :length =>{:within => 2..30}
  validates :descriptoin, :presence => true, :length => {:within => 2..300}
end
