class LeagueOrganiser
  def initialize
    @players = []
    @has_started = false
    @matches = []
    @winners = {}
  end

  def add_player(name)
    raise "Can't add players once the league has started." if @has_started
    @players << name
  end

  def start_league
    raise "The league needs at least two players to start." if @players.length < 2
    @has_started = true
    @matches = generate_matches(@players)
  end

  def show_matches
    raise "Cannot show matches: League hasn't started yet." if !@has_started
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

  def record_win(match_id, winner)
    raise "Wrong match number: #{match_id}." if match_id > @matches.length
    raise "Wrong player name: #{winner}." if !@matches[match_id - 1].include? winner
    @winners[match_id] = winner
  end

  def overall_winner
    raise "Cannot determine winner: League hasn't ended yet." if @winners.length < @matches.length
    return calculate_overall_winner
  end

  private

  def generate_matches(players)
    players.combination(2).to_a
  end

  # buggy if more than one player has the same number of win
  def calculate_overall_winner
    nb_of_wins_per_player = {}
    @players.each do | name |
      nb_of_wins_per_player[name] = @winners.values.count(name)
    end
    max_num_of_win = nb_of_wins_per_player.values.max
    return nb_of_wins_per_player.key(max_num_of_win)
  end

end