# vim: set tabstop=2 :

class Player < ActiveRecord::Base

  def self.logged_in_players(myID)
    # Return all the other logged-in players.

    return Player.all(:conditions=>
      ["logged_in is not null and id != ?", myID])
  end

end
