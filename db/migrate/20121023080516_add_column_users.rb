class AddColumnUsers < ActiveRecord::Migration

  def change
    add_column :users, :provider ,:string, :length=>30
    add_column :users, :uid, :string
    add_column :users, :name, :string, :null=>true
    add_column :users, :screen_name, :string, :null=>true
    add_column :users, :image, :string
    
    remove_column :users, :email
    remove_column :users, :encrypted_password
    remove_column :users, :user_name
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :sign_in_count
    remove_column :users, :current_sign_in_at
    remove_column :users, :last_sign_in_at
    remove_column :users, :current_sign_in_ip
    remove_column :users, :last_sign_in
  end

end
