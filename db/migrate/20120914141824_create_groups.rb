class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name ,:null=>false, :length=>30
      t.timestamps
    end
  end
end
