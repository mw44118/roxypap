# vim: set tabstop=2 :

class LoginAlreadyTaken < Exception
end

class Player < ActiveRecord::Base

  def self.authenticate(login, password)
    return Player.find_by_login_and_password login, password
  end

  def other_logged_in_players
    return Player.all(:conditions=>
      ["logged_in is not null and id != ?", self.id])
  end

  def invite(invited)
    return Game.send_invite(self, invited)
  end

  def received_invites
    Game.all(:conditions=>["invited_id = ? and accepted = ?", id, false])
  end

  def number_of_received_invites
    Game.count(:conditions=>["invited_id = ? and accepted = ?", id, false])
  end

  def delivered_invites
    return Game.all(
      :conditions=>["inviter_id = ? and accepted = ?", id, false])
  end

  def number_of_my_unfinished_games

    Game.count(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status in (?, ?)",
        self.id, self.id, 'invitation accepted', 'in progress'])

  end

  def my_unfinished_games

    Game.all(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status in (?, ?)",
        self.id, self.id, 'invitation accepted', 'in progress'])

  end

  def make_move(g, move)
    g.make_move(self, move)
  end

  def accept_invite(g)
    g.accept_invite
  end

  def games_finished

    return Game.all(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status = ?",
        id, id, 'finished'])

  end

  def number_of_games
    return Game.count(:conditions=>[
      "(inviter_id = ? or invited_id = ?) and status = ?",
      id, id, 'finished'])
  end

  def games_won

    return Game.all(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status = ? and winner_id = ?",
        id, id, 'finished', id])

  end

  def number_of_wins

    return Game.count(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status = ? and winner_id = ?",
        id, id, 'finished', id])

  end

  def number_of_losses

    return Game.count(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status = ? and winner_id != ?",
        id, id, 'finished', id])

  end

  def number_of_ties

    return Game.count(
      :conditions=>[
        "(inviter_id = ? or invited_id = ?) and status = ?",
        id, id, 'tied'])
  end

  def my_record
    return "#{self.number_of_wins}-#{self.number_of_losses}-#{self.number_of_ties}"

  end

  def self.leaderboard

    return Player.all.sort do |p1, p2|
      if p1.number_of_wins != p2.number_of_wins
        p1.number_of_wins <=> p2.number_of_wins
      else
        p1.number_of_games <=> p2.number_of_games
      end
    end .reverse

  end

  def self.register(login, password)

    if not Player.find_by_login(login).nil?
      raise LoginAlreadyTaken, login
    end

    p = Player.new(:login=>login, :password=>password)
    p.save

  end

end
