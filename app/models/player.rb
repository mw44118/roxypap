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
    return g
  end

  def received_invites
    Game.all(:conditions=>["invited_id = ? and accepted = ?", id, false])
  end

  def delivered_invites
    return Game.all(:conditions=>["inviter_id = ? and accepted = ?", id, false])
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

  def accept_invite(g)

    g.accepted = true
    g.save

  end

end
