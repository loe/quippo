class AddTwitterIdToQuips < ActiveRecord::Migration
  def self.up
    add_column :quips, :twitter_id, :integer
  end

  def self.down
    remove_column :quips, :twitter_id
  end
end
