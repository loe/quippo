class AddAttributions < ActiveRecord::Migration
  def self.up
    add_column :quips, :attribution, :string
  end

  def self.down
    remove_column :quips, :attribution
  end
end
