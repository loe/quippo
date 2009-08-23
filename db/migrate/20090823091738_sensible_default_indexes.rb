class SensibleDefaultIndexes < ActiveRecord::Migration
  def self.up
    add_index :quips, :user_id
    add_index :users, :twitter_screen_name
  end

  def self.down
    remove_index :users, :twitter_screen_name
    remove_index :quips, :user_id
  end
end
