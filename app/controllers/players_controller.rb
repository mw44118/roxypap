# vim: set tabstop=2 :

class PlayersController < ApplicationController

  before_filter :require_authentication, :except => [
    :login, :leaderboard, :register]

  def received
    @me = Player.find(session[:player_id])
    @pagetitle = "Invitations sent to me"

  end

  def login

    if session[:player_id]
      return redirect_to :controller => 'players', :action => 'others'
    end

    @pagetitle = "Log in"

    if request.post?

      p = Player.find_by_login_and_password(
        params['login'], params['password'])

      if p.nil?
          flash[:notice] = "Sorry, bad credentials"

      else
          flash[:notice] = "Hi #{p.login} -- welcome!"
          p.logged_in = DateTime.now
          p.save

          session[:player_id] = p.id

          if session[:redirect_to].nil?

            redirect_to :controller => 'players', :action => 'others'

          else
              redirect_to session[:redirect_to]

          end

      end

    else
      logger.debug('GET')
    end

  end

  def logout

    @me = Player.find session[:player_id]

    if request.post?

      session[:player_id] = nil
      flash[:notice] = "You are logged out"
      redirect_to :action => "login"

    end

  end

  def others

    @pagetitle = "Other logged-in players"

    @me = Player.find session[:player_id]

    @players = @me.other_logged_in_players

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


  def register

    @pagetitle = "Register"

    # Store and redirect
    if request.post?

      begin
        Player.register(params['login'], params['password'])
      rescue LoginAlreadyTaken => ex
        flash[:error] = "Choose a different name"
        return redirect_to :controller => 'players', :action => 'register'
      end

      if session[:redirect_to].nil?

        return redirect_to :controller => 'players', :action => 'others'

      else
        return redirect_to session[:redirect_to]

      end

    else
      logger.debug('GET inside register')
    end

  end

end
