class IndexQuipsOnTwitterId < ActiveRecord::Migration
  def self.up
    add_index :quips, :twitter_id
  end

  def self.down
    remove_index :quips, :twitter_id
  end
end
