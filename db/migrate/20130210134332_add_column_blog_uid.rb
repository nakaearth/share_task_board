class AddColumnBlogUid < ActiveRecord::Migration
  def change 
    add_column :blogs, :blog_uid ,:string, :default => "",  :null => false
    add_index :blogs ,[:blog_uid]
  end

end
