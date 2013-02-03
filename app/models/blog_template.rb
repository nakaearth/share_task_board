class BlogTemplate < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :body, :format, :handler, :locale, :partial, :path
end
