class RenameGameColumns < ActiveRecord::Migration
  def self.up
    rename_column :games, :inviter, :inviter_id
    rename_column :games, :invited, :invited_id
  end

  def self.down
  end
end
