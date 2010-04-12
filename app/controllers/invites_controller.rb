# vim: set tabstop=2 :

class InvitesController < ApplicationController

  def invite

    if request.post?

      me = Player.find(session[:player_id])
      opponent = Player.find(params[:to_player])
      me.invite(opponent)
      flash[:notice] = "I sent an invite to #{opponent.login}"
      redirect_to :controller => 'players', :action => 'others'

    end

  end

  def received

    @pagetitle = "Invites sent to me"
    @me = Player.find(session[:player_id])

  end

  def accept

    if request.post?

      me = Player.find(session[:player_id])
      g = Game.find(params['gID'])
      me.accept_invite(g)

      flash[:notice] = "Created game #{g.id}"

      redirect_to :controller => 'games', :action => 'play', :id => g.id

    end

  end

end
