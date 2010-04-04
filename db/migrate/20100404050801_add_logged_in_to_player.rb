class AddLoggedInToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :logged_in, :date
  end

  def self.down
    remove_column :players, :logged_in
  end
end
