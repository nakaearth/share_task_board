class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :blog_template_id

      t.timestamps
    end
    rename_column :blog_templates, :user_id ,:blog_id  
  end
end
