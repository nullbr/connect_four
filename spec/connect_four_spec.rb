require './lib/connect_four'

RSpec.describe ConnectFour do
  describe '#display_board' do
    it 'returns an empty board' do
      game = ConnectFour.new('Bruno', 1, 'Giu', 2)
      empty_board = "   1 2 3 4 5 6 7 8\n"\
      "6 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "5 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "4 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "3 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "2 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "1 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "   1 2 3 4 5 6 7 8"
      expect(game.display_board).to eq(empty_board)
    end
  end
end