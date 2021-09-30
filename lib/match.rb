class Match
  attr_reader :winner
  
  def initialize(players)
    raise 'Match must have 2 players' if players.count != 2
    @players = players
  end

  def record_a_win(winner)
    raise "Wrong player name: #{winner}" if !@players.include?(winner)
    @winner = winner
  end
  
  def player1
    @players[0]
  end

  def player2
    @players[1]
  end
end
