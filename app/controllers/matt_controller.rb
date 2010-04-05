# vim: set tabstop=2 :

class MattController < ApplicationController

  def login

    if request.post?

      p = Player.find_by_login_and_password(
        params['login'], params['password'])

      if p.nil?
          flash[:notice] = "Sorry, bad credentials"

      else
          flash[:notice] = "Hi #{p.login} -- welcome!"
          p.logged_in = DateTime.now
          session[:player_id] = p.id

          p.save # Apparently, this is pretty important :)

          if params['redirect_to'].nil?
              redirect_to :controller => 'players', :action => 'others'

          else
              redirect_to params['redirect_to']

          end

      end

    else
      logger.debug('GET')
    end

  end

  def logout

    if request.post?

      session[:player_id] = nil
      flash[:notice] = "You are logged out"
      redirect_to(:action => "login")

    end

  end

end
