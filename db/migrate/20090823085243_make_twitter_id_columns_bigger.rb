class MakeTwitterIdColumnsBigger < ActiveRecord::Migration
  def self.up
    change_column :quips, :twitter_id, :integer, :limit => 8
    change_column :users, :twitter_id, :integer, :limit => 8
  end

  def self.down
    change_column :users, :twitter_id, :integer
    change_column :quips, :twitter_id, :integer
  end
end
