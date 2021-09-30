require 'league_organiser'

describe LeagueOrganiser do
  let(:match_class) { double :match_class, new: match }
  let(:match) { double :match, players: ['Lewis', 'Ana'], id: 1 }

  before(:each) do
    @league = LeagueOrganiser.new(['Lewis', 'Ana'], match_class)
    allow(match).to receive(:players).and_return ['Lewis', 'Ana']
  end


  describe "#show_matches" do
    it 'shows matches' do
      allow(match).to receive(:winner)

      expect{@league.show_matches}.to output(
        <<-matches
Match 1: Lewis vs Ana
        matches
      ).to_stdout
    end
  end

  describe '#record_a_win' do
    it 'records_a_win' do
      allow(match).to receive(:record_a_win).and_return 'Lewis'
      allow(match).to receive(:winner).and_return 'Lewis'

      @league.record_a_win(1, 'Lewis')
      expect{@league.show_matches}.to output(
        <<-matches
Match 1: Lewis vs Ana, Lewis wins
        matches
      ).to_stdout
    end
  end
end
