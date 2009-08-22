class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :twitter_atoken
      t.string :twitter_asecret
      t.integer :twitter_id
      t.string :twitter_username

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
