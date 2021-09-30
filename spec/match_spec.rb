require 'match'

describe Match do
  describe "#initialize" do
    it 'sets the two players in the match' do
      match = Match.new(1, ['Lewis', 'Guy'])
    end

    it 'stops the user creating a match with less than 2 players' do
      expect { Match.new(1, ['Lewis']) }.to raise_error 'Match must have 2 players'
    end

    it 'stops the user creating a match with more than 2 players' do
      expect { Match.new(1, ['Lewis', 'Guy', 'Ana']) }.to raise_error 'Match must have 2 players'
    end

    it "uses different id and names" do
      match = Match.new(4, ['Ana', 'Dave'])
      expect(match.id).to eq 4
      expect(match.players).to eq ['Ana', 'Dave']
    end
  end

  context 'players' do
    before(:each) { @match = Match.new(1, ['Lewis', 'Guy']) }

    describe "#players" do
      it 'returns the name of player 1' do
        expect(@match.players[0]).to eq 'Lewis'
      end
    end

    describe "#player2" do
      it 'returns the name of player 2' do
        expect(@match.players[1]).to eq 'Guy'
      end
    end
  end

  describe "#record_a_win" do
    before(:each) { @match = Match.new(1, ['Lewis', 'Guy']) }

    it 'sets the winner to one of the players in the match' do
      @match.record_a_win('Guy')
      expect(@match.winner).to eq 'Guy'
    end

    it 'stops the user recording a winner if the provided player isnt in the match' do
      expect { @match.record_a_win('Ana') }. to raise_error 'Wrong player name: Ana.'
    end
  end
end
