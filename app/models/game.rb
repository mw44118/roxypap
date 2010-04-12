# vim: set tabstop=2 :

class Game < ActiveRecord::Base

  belongs_to :theme

  belongs_to :inviter, :class_name => "Player"
  belongs_to :invited, :class_name => "Player"

  belongs_to :winner, :class_name => "Player"

  def my_move(me)

    if me == inviter
      return inviter_move
    end

    if me == invited
      return invited_move
    end

  end

  def make_move(mover, move)

    if mover == inviter
      self.inviter_move = move
    end

    if mover == invited
      self.invited_move = move
    end

    if !self.inviter_move.nil? ^ !self.invited_move.nil?
      self.status = "in progress"
    end

    if self.inviter_move and self.invited_move
      self.winner = figure_out_winner
      if self.winner
        self.status = 'finished'
      else
        self.status = 'tied'
      end
    end

    save

  end

  def tied
    self.status == 'tied'
  end

  def figure_out_winner()

    if inviter_move.nil? or invited_move.nil? or inviter_move == invited_move
      return nil
    end

    if ((inviter_move == 'rock' and invited_move == 'scissors') or (inviter_move == 'scissors' and invited_move == 'paper') or (inviter_move == 'paper' and invited_move == 'rock'))

      return inviter

    else

      return invited

    end

  end


  def self.send_invite(inviter, invited)

    g = Game.new :inviter=>inviter, :invited=>invited,
      :status=>"invitation sent"

    g.save
    return g

  end

  def my_opponent(me)

    if me == inviter
      return invited
    end

    if me == invited
      return inviter
    end

  end

  def accept_invite
    self.status = "invitation accepted"
    self.accepted = true
    self.save

  end

  def self.my_unfinished_games(myID)
    Game.all(:conditions=>[
      "status not in ('tied', 'finished') and (inviter_id = ? or invited_id = ?)", myID, myID])

  end


end
