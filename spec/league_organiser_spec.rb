require 'league_organiser'

describe 'league_organiser' do

  describe 'work in happy scenarios' do
    it 'calculates the winner correctly' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.add_player("Charlie")
      league_organiser.start_league
        # Match 1: Alice vs Bob
        # Match 2: Alice vs Charlie
        # Match 3: Bob vs Charlie
      league_organiser.record_win(1, "Alice")
      league_organiser.record_win(2, "Charlie")
      league_organiser.record_win(3, "Charlie")
      expect(league_organiser.overall_winner).to eq "Charlie"
    end
  
    it 'displays matches as expected' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.add_player("Charlie")
      league_organiser.add_player("Denise")
      league_organiser.add_player("Emily")
      league_organiser.start_league
      league_organiser.record_win(1, "Alice")
      league_organiser.record_win(2, "Charlie")
      league_organiser.record_win(6, "Bob")
      expect{league_organiser.show_matches}.to output(
<<-matches
Match 1: Alice vs Bob, Alice wins
Match 2: Alice vs Charlie, Charlie wins
Match 3: Alice vs Denise
Match 4: Alice vs Emily
Match 5: Bob vs Charlie
Match 6: Bob vs Denise, Bob wins
Match 7: Bob vs Emily
Match 8: Charlie vs Denise
Match 9: Charlie vs Emily
Match 10: Denise vs Emily
matches
      ).to_stdout
    end
  end

  describe 'correctly errors in unhappy scenarios' do
    it 'throws an error if trying to record a win with wrong Player' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.add_player("Charlie")
      league_organiser.start_league
        # Match 1: Alice vs Bob
        # Match 2: Alice vs Charlie
        # Match 3: Bob vs Charlie
      expect{league_organiser.record_win(1, "Charlie")}.to raise_error("Wrong player name: Charlie.")
    end

    it 'throws an error if trying to record a win with wrong id' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.add_player("Charlie")
      league_organiser.start_league
        # Match 1: Alice vs Bob
        # Match 2: Alice vs Charlie
        # Match 3: Bob vs Charlie
      expect{league_organiser.record_win(4, "Charlie")}.to raise_error("Wrong match number: 4.")
    end

    it 'throws an error if trying to add a player after the league has started' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.start_league
      expect{league_organiser.add_player("Charlie")}.to raise_error("Can't add players once the league has started.")
    end

    it 'throws an error if trying to start the league with only one player' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      expect{league_organiser.start_league}.to raise_error("The league needs at least two players to start.")
    end

    it 'throws an error if trying to show matches before the league has started' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.add_player("Charlie")
      expect{league_organiser.show_matches}.to raise_error("Cannot show matches: League hasn't started yet.")
    end

    it 'throws an error if trying to get the winner before all the matches have been played' do
      league_organiser = LeagueOrganiser.new
      league_organiser.add_player("Alice")
      league_organiser.add_player("Bob")
      league_organiser.add_player("Charlie")
      league_organiser.start_league
      league_organiser.record_win(1, "Alice")
      league_organiser.record_win(2, "Charlie")
      expect{league_organiser.overall_winner}.to raise_error("Cannot determine winner: League hasn't ended yet.")
    end
  end
end