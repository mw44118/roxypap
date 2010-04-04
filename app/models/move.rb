class Move < ActiveRecord::Base

    belongs_to :game
    belongs_to :player
    validates_inclusion_of :choice, :in => %w( rock scissors paper )

end
