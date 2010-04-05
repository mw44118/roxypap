# vim: set tabstop=2 :

class InvitesController < ApplicationController

  def invite

    if request.post?

      Invite.send_invite(session[:player_id], params[:to_player])

      to_player = Player.find(params[:to_player])
      flash[:notice] = "I sent an invite to #{to_player.login}"

      redirect_to :controller => 'players', :action => 'others'

    end

  end

end
