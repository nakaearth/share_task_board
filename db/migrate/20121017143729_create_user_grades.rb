class CreateUserGrades < ActiveRecord::Migration
  def change
    create_table :user_grades do |t|
      t.integer :user_id,:null=>false
      t.integer :user_grade,:null=>false, :default=>1
      t.timestamps
    end
    add_index :user_grades,[:user_id]
  end
end
