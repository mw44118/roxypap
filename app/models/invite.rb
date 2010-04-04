class Invite < ActiveRecord::Base

    belongs_to :from_player, class_name => "Player"
    belongs_to :to_player, class_name => "Player"

end
