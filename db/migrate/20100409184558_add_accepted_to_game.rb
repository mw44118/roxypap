class AddAcceptedToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :accepted, :boolean, :default => false
  end

  def self.down
  end
end
