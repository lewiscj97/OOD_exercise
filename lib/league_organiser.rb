require_relative 'match'

class LeagueOrganiser

  def initialize(players, match = Match)
    raise "A league needs at least two players." if players.length < 2
    @match_class = match
    @matches = generate_matches(players)
  end

  def show_matches
    matches_strings = @matches.map.with_index do | match, index |
      player_1, player_2 = match.players
      string = "Match #{match.id}: #{player_1} vs #{player_2}"
      string += ", #{match.winner} wins" if match.winner
      string
    end
    puts matches_strings.join("\n")
  end

  def record_a_win(match_id, winner)
    raise "Wrong match number: #{match_id}." if match_id > @matches.length
    @matches[match_id - 1].record_a_win(winner)
  end

  def overall_winner
    @matches.each do |match|
      raise "Cannot determine winner: Some matches do not have a winner yet." if match.winner.nil?
    end
    calculate_overall_winner
  end

  private

  def generate_matches(players)
    players.combination(2).to_a.map.with_index{ |match, index| @match_class.new((index+1), match) }
  end

  # buggy if more than one player has the same number of points
  def calculate_overall_winner
    points_per_player = {}
    @matches.each do | match |
      !points_per_player[match.winner].nil? ? (points_per_player[match.winner] += 1) : (points_per_player[match.winner] = 1)
    end
    max_points = points_per_player.values.max
    points_per_player.key(max_points)
  end

end