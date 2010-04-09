# vim: set tabstop=2 :

class Player < ActiveRecord::Base

  def self.logged_in_players(myID)
    # Return all the other logged-in players.

    return Player.all(:conditions=>
      ["logged_in is not null and id != ?", myID])
  end

  def invite(invited)
    g = Game.new(:inviter=>self, :invited=>invited)
    g.save
    g
  end

  def received_invites
    Game.all(:conditions=>["invited = ?", self])
  end

  def delivered_invites
    Game.all(:conditions=>["inviter = ? and accepted = ?", self, false])
  end

  def make_move(g, move)

    if g.inviter == self
      g.inviter_move = move
      return g
    end

    if g.invited == self
      g.invited_move = move
      return g
    end

  end

end
