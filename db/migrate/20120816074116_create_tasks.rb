class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title,  :null=> false, :default =>""
      t.text :description, :null=>false, :default => ""
      t.integer :status, :null=>false, :default=>1
      t.integer :priority, :null=>false,  :default=>0
      t.integer :user_id, :null => false
      t.timestamps
    end
    add_index :tasks,[:status,:priority]
  end
end
