class Blog < ActiveRecord::Base
  belongs_to :user
  has_one :blog_template
  has_many :articles

  validates :name, :presence =>true ,:length=>{:within=>5..80}
  validates :description ,:presence=>true ,:length=>{:within=>5..270}
  validates :blog_uid ,:presence=>true,:uniqueness => true ,:length=>{:within=>6..30}
  
  #attr_accessible :blog_template_id, :description, :name, :user_id

  
end
