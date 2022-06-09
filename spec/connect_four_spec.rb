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
      '   1 2 3 4 5 6 7 8'
      expect(game.display_board).to eq(empty_board)
    end
  end

  describe '#build_game' do
    context 'returns an 6x8 array of arryas filled hollow circles' do
      row = ['⭕', '⭕', '⭕', '⭕', '⭕', '⭕', '⭕', '⭕']

      it 'row 1, contains 8 hollow circles' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        expect(game.build_grid[0]).to eq(row)
      end

      it 'row 6, contains 8 hollow circles' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        expect(game.build_grid[5]).to eq(row)
      end
    end
  end

  describe '#input' do
    context 'inputs a circle in a valid spot' do
      game = ConnectFour.new('Bruno', 1, 'Giu', 2)

      it 'Bruno puts a white circle at position 1x1' do
        game.input(1, 1)
        expect(game.grid[0][0]).to eq('⚪')
      end

      it 'Giu puts a blue circle at position 1x8' do
        game.input(1, 8)
        expect(game.grid[0][7]).to eq('🔵')
      end
    end
  end
end
