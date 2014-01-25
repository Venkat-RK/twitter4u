class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :user, :null => false
      t.text :content, :limit => 160
      t.boolean :type, :default => true

      t.timestamps
    end
    add_index :tweets, :user_id
  end
end
