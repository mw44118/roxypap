class AddAcceptedToGame < ActiveRecord::Migration
  def self.up
    add_column :games, :accepted, :boolean, :default => 0
  end

  def self.down
  end
end
