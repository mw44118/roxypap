class AddLoggedIn2ToPlayer < ActiveRecord::Migration
  def self.up
    add_column :players, :logged_in, :datetime
  end

  def self.down
    remove_column :players, :logged_in
  end
end
