# vim: set tabstop=2 :

class PlayersController < ApplicationController

  before_filter :require_authentication

  def others

    @pagetitle = "Other logged-in players"

    @players = Player.logged_in_players(session[:player_id])

    @invited = Invite.all(
      :conditions=>["from_player_id = ?",
        session[:player_id]]
    ).map do |inv| inv.to_player_id end

  end

end
