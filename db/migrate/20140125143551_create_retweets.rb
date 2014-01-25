class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :tweet, :null => false
      t.references :user, :null => false

      t.timestamps
    end
    add_index :retweets, :tweet_id
    add_index :retweets, :user_id
  end
end
