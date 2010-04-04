# vim: set tabstop=2 :

class MattController < ApplicationController

  def login

    if request.post?
      logger.debug('POST')

      p = Player.find_by_login_and_password(
        params['login'], params['password'])

      if p.nil?
          logger.debug('Somebody failed...')

          # Redraw the form and tell them that the credentials weren't
          # any good.

      else
          logger.debug('SUCCESS')
          p.logged_in = DateTime.now

          if params['redirect_to'].nil?
              redirect_to '/players'

          else
              redirect_to params['redirect_to']

          end

      end

    else
      logger.debug('GET')
    end

  end

end
