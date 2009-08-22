class RenameTwitterUsername < ActiveRecord::Migration
  def self.up
    rename_column :users, :twitter_username, :twitter_screen_name
  end

  def self.down
    rename_column :users, :twitter_screen_name, :twitter_username
  end
end
