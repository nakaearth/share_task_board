class Group < ActiveRecord::Base
  attr_accessible :name

  validates :name ,:presence=>true ,:length=>{:within=>5..80}

  has_many :group_maps
  has_many :users, :through=>:group_maps
  has_many :jobs


  def save_group_user(input_attr)
    begin
      transaction do
        @group=Group.new
        @group.name=input_attr[:name]
        @group.save
        if @group  
          @map=GroupMap.new
          @map.user_id=input_attr[:user_id]
          @map.group_id=@group.id
          @map.save
        end
      end
    rescue ActiveRecord::StatementInvalid => ae
      logger.error "GROUP INFO SAVE ERROR."+ae.message
    end
  end
end
