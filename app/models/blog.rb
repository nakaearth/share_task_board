class Blog < ActiveRecord::Base
  belongs_to :user
  has_one :blog_template
  has_many :articles

  validates :name, :presence =>true ,:length=>{:within=>5..80}
  validates :description ,:presence=>true ,:length=>{:within=>1..270}
  
  #attr_accessible :blog_template_id, :description, :name, :user_id
end
