class CreateQuips < ActiveRecord::Migration
  def self.up
    create_table :quips do |t|
      t.integer :user_id
      t.text :text
      t.boolean :private

      t.timestamps
    end
  end

  def self.down
    drop_table :quips
  end
end
