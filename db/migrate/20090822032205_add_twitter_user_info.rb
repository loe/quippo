class AddTwitterUserInfo < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_name, :string
    add_column :users, :twitter_profile_image_url, :string
  end

  def self.down
    remove_column :users, :twitter_profile_image_url
    remove_column :users, :twitter_name
  end
end
