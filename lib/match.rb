class Match
  attr_reader :winner, :id
  
  def initialize(id, players)
    raise 'Match must have 2 players' if players.count != 2
    @id = id
    @players = players
  end

  def record_a_win(winner)
    raise "Wrong player name: #{winner}." if !@players.include?(winner)
    @winner = winner
  end

  def players
    @players.map(&:clone)
  end
end
