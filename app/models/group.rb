class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :group_maps
  has_many :users, :through=>:group_maps
  has_many :jobs

  def save_group_user(params)
    @group=Group.new
    @group.name=params[:name]
    @group.save
    p @group
 
    @map=GroupMap.new
    @map.user_id=params[:user_id]
    @map.group_id=@group.id
    @map.save
  end
end
