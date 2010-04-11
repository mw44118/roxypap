class RenameMoreColumnsInGame < ActiveRecord::Migration
  def self.up
    rename_column :games, :winner, :winner_id
  end

  def self.down
  end
end
