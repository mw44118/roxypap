# vim: set tabstop=2 :

class Invite < ActiveRecord::Base

  belongs_to :from_player, :class_name => "Player"
  belongs_to :to_player, :class_name => "Player"

  def self.send_invite(from_player_id, to_player_id)

    # Return an invite already created or create a new one.

    results = Invite.all(
        :conditions=>["from_player_id = ? and to_player_id = ?",
            from_player_id, to_player_id])

    if results.count > 0
        return results[0]
    end

    Invite.new(
      :from_player_id=>from_player_id,
      :to_player_id=>to_player_id).save

  end

end
