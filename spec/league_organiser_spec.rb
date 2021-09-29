require 'league_organiser'

describe 'LeagueOrganiser' do

  describe 'work in happy scenarios' do
    it 'calculates the winner correctly' do
      league = LeagueOrganiser.new(["Alice", "Bob", "Charlie"])
        # Match 1: Alice vs Bob
        # Match 2: Alice vs Charlie
        # Match 3: Bob vs Charlie
      league.record_a_win(1, "Alice")
      league.record_a_win(2, "Charlie")
      league.record_a_win(3, "Charlie")
      expect(league.overall_winner).to eq "Charlie"
    end
  
    it 'displays matches as expected' do
      league = LeagueOrganiser.new(["Alice", "Bob", "Charlie", "Denise", "Emily"])
      league.record_a_win(1, "Alice")
      league.record_a_win(2, "Charlie")
      league.record_a_win(6, "Bob")
      expect{league.show_matches}.to output(
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
      league = LeagueOrganiser.new(["Alice", "Bob", "Charlie"])
        # Match 1: Alice vs Bob
        # Match 2: Alice vs Charlie
        # Match 3: Bob vs Charlie
      expect{league.record_a_win(1, "Charlie")}.to raise_error("Wrong player name: Charlie.")
    end

    it 'throws an error if trying to record a win with wrong id' do
      league = LeagueOrganiser.new(["Alice", "Bob", "Charlie"])
        # Match 1: Alice vs Bob
        # Match 2: Alice vs Charlie
        # Match 3: Bob vs Charlie
      expect{league.record_a_win(4, "Charlie")}.to raise_error("Wrong match number: 4.")
    end

    it 'throws an error if trying to create a league with only one player' do
      expect{LeagueOrganiser.new(["Alice"])}.to raise_error("A league needs at least two players.")
    end

    it 'throws an error if trying to get the winner before all the matches have been played' do
      league = LeagueOrganiser.new(["Alice", "Bob", "Charlie"])
      league.record_a_win(1, "Alice")
      league.record_a_win(2, "Charlie")
      expect{league.overall_winner}.to raise_error("Cannot determine winner: Some matches do not have a winner yet.")
    end
  end
end