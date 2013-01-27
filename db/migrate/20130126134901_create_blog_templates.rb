class CreateBlogTemplates < ActiveRecord::Migration
  def change
    create_table :blog_templates do |t|
      t.text :body
      t.string :path
      t.string :format
      t.string :locale
      t.string :handler
      t.boolean :partial
      t.integer :user_id
      t.timestamps
    end 
    
  end
end
