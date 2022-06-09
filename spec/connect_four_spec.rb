require './lib/connect_four'

RSpec.describe ConnectFour do
  describe '#display_board' do
    it 'returns an empty board' do
      game = ConnectFour.new('Bruno', 1, 'Giu', 2)
      empty_board = "   1 2 3 4 5 6 7 8\n"\
      "6 ⭕⭕⭕⭕⭕⭕⭕⭕ 6\n"\
      "5 ⭕⭕⭕⭕⭕⭕⭕⭕ 5\n"\
      "4 ⭕⭕⭕⭕⭕⭕⭕⭕ 4\n"\
      "3 ⭕⭕⭕⭕⭕⭕⭕⭕ 3\n"\
      "2 ⭕⭕⭕⭕⭕⭕⭕⭕ 2\n"\
      "1 ⭕⭕⭕⭕⭕⭕⭕⭕ 1\n"\
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

  describe '#input_valid?' do
    context 'Check if input is out of grid:' do
      game = ConnectFour.new('Bruno', 1, 'Giu', 2)
      it 'returns false if input x is out of grid' do
        expect(game.input_valid?(-1, 0)).to_not be_truthy
      end

      it 'returns false if input y is out of grid' do
        expect(game.input_valid?(1, 9)).to_not be_truthy
      end
    end

    context 'Check if spot has been taken:' do
      it 'returns false if input two in the same spot' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        game.input(1, 1)
        expect(game.input_valid?(1, 1)).to_not be_truthy
      end
    end

    context 'Check that a circle can only be placed on top of another one:' do
      game = ConnectFour.new('Bruno', 1, 'Giu', 2)
      it 'returns false if input cannot be placed on row 2' do
        expect(game.input_valid?(1, 2)).to_not be_truthy
      end

      it 'returns true if input is on top of an existing input' do
        game.input(1, 1)
        puts game.display_board
        expect(game.input_valid?(1, 2)).to be_truthy
      end
    end
  end
end
