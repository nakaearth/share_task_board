class AddColumnUsersRole < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'normal', null: 'false'
    @user = User.where('name = ?', 's_nakamura').first
    if @user
      @user.role = "admin"
      @user.save
    end
  end

end
