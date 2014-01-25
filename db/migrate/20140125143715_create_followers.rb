class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.references :user, :null => false
      t.integer :follower_id, :null => false

      t.timestamps
    end
    add_index :followers, :user_id
  end
end
