class RemoveLoggedInFromPlayer < ActiveRecord::Migration
  def self.up
    remove_column :players, :logged_in
  end

  def self.down
  end
end
