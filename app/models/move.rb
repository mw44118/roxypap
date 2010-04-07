# vim: set tabstop=2 :

class Move < ActiveRecord::Base

  belongs_to :game
  belongs_to :player
  # validates_inclusion_of :choice, :in => %w( rock scissors paper )

  def self.calculate_winning_move(m1, m2)

    if m1.choice.nil? or m2.choice.nil? or m1.choice == m2.choice
      return nil
    end

    # All the ways m1 can win.
    # HOW DO I BREAK THIS LINE UP ???
    if ((m1.choice == 'rock' and m2.choice == 'scissors') or (m1.choice == 'scissors' and m2.choice == 'paper') or (m1.choice == 'paper' and m2.choice == 'rock'))

      return m1

    else

      return m2

    end

  end

end
