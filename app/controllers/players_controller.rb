# vim: set tabstop=2 :

class PlayersController < ApplicationController

  before_filter :require_authentication, :except => [:leaderboard]

  def others

    @pagetitle = "Other logged-in players"

    @players = Player.logged_in_players(session[:player_id])

    @me = Player.find session[:player_id]

    @invited = @me.delivered_invites.map do |p| p.invited end

  end

  def leaderboard

    if session[:player_id]
      @me = Player.find session[:player_id]
    else
      @me = nil
    end

    @pagetitle = "LeaderBoard"
    @lb = Player.leaderboard
  end

end
