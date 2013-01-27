class BlogTemplate < ActiveRecord::Base
  belongs_to :blog_template
  attr_accessible :body, :format, :handler, :locale, :partial, :path
end
