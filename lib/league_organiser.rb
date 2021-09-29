class LeagueOrganiser

  def initialize(players)
    raise "A league needs at least two players." if players.length < 2
    @players = players
    @matches = generate_matches(@players)
    @winners = {}
  end

  def show_matches
    matches_strings = @matches.map.with_index do | players, index |
      player_1, player_2 = players
      string = "Match #{index + 1}: #{player_1} vs #{player_2}"
      if @winners.include?(index + 1)
        string += ", #{@winners[index + 1]} wins"
      end
      string
    end
    puts matches_strings.join("\n")
  end

  def record_a_win(match_id, winner)
    raise "Wrong match number: #{match_id}." if match_id > @matches.length
    raise "Wrong player name: #{winner}." if !@matches[match_id - 1].include? winner
    @winners[match_id] = winner
  end

  def overall_winner
    raise "Cannot determine winner: Some matches do not have a winner yet." if @winners.length < @matches.length
    return calculate_overall_winner
  end

  private

  def generate_matches(players)
    players.combination(2).to_a
  end

  # buggy if more than one player has the same number of win
  def calculate_overall_winner
    number_of_wins_per_player = {}
    @players.each do | name |
      number_of_wins_per_player[name] = @winners.values.count(name)
    end
    max_number_of_win = number_of_wins_per_player.values.max
    return number_of_wins_per_player.key(max_number_of_win)
  end

end