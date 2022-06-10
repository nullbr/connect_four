require './lib/connect_four'

RSpec.describe ConnectFour do
  describe '#display_board' do
    it 'returns an empty board' do
      game = ConnectFour.new('Bruno', 0, 'Giu', 1)
      empty_board = " 1 2 3 4 5 6 7 8\n"\
      "⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      "⭕⭕⭕⭕⭕⭕⭕⭕\n"\
      ' 1 2 3 4 5 6 7 8'
      expect(game.display_board).to eq(empty_board)
    end
  end

  describe '#build_game' do
    context 'returns an 6x8 array of arryas filled hollow circles' do
      row = ['⭕', '⭕', '⭕', '⭕', '⭕', '⭕', '⭕', '⭕']

      it 'row 1, contains 8 hollow circles' do
        game = ConnectFour.new('Bruno', 0, 'Giu', 1)
        expect(game.build_grid[0]).to eq(row)
      end

      it 'row 6, contains 8 hollow circles' do
        game = ConnectFour.new('Bruno', 0, 'Giu', 1)
        expect(game.build_grid[5]).to eq(row)
      end
    end
  end

  describe '#input' do
    game = ConnectFour.new('Bruno', 0, 'Giu', 1)
    context 'inputs a circle in a valid spot:' do

      it 'Bruno puts a white circle at position 1x1' do
        game.input(1)
        expect(game.grid[0][0]).to eq('⚪')
      end

      it 'Giu puts a blue circle at position 8x1' do
        game.next_player
        game.input(8)
        expect(game.grid[0][7]).to eq('🔵')
      end
    end
  end

  describe '#next_player' do
    it 'switches to Giu' do
      game = ConnectFour.new('Bruno', 0, 'Giu', 1)
      game.next_player
      expect(game.current_player[:name]).to eq('Giu')
    end
  end

  describe '#input_valid?' do
    context 'Check if input is out of grid:' do
      game = ConnectFour.new('Bruno', 0, 'Giu', 1)
      it 'returns false if input -1' do
        expect(game.input_valid?(-1)).to_not be_truthy
      end

      it 'returns false if input 9' do
        expect(game.input_valid?(9)).to_not be_truthy
      end
    end

    context 'Check that a circle can be placed on top of another:' do
      game = ConnectFour.new('Bruno', 0, 'Giu', 1)
      it 'returns false if input would be placed outside of grid' do
        game.grid[5][0] = '🔵'
        expect(game.input_valid?(1)).to_not be_truthy
      end

      it 'returns true if input is on top of an existing input' do
        game.input(2)
        game.input(2)
        expect(game.input_valid?(2)).to be_truthy
      end
    end
  end

  describe '#game_over?' do
    context 'returns true if someone won horizontally:' do
      it 'last input at 2' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        3.times { |n| game.grid[0][n + 2] = '🔵' }
        game.input(2)
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'last input at 4' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        3.times { |n| game.grid[0][n] = '🔵' }
        game.input(4)
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'last input at 5' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        3.times { |n| game.grid[0][n + 5] = '🔵' }
        game.input(5)
        puts game.display_board
        expect(game.game_over?).to be_truthy
      end
    end

    context 'returns true if someone won verticaly:' do
      it 'win at column 1' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        4.times { game.input(1) }
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'win at column 4' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        4.times { game.input(4) }
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'win at column 8' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        4.times { game.input(8) }
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end
    end

    context 'returns true if someone won diagonally:' do
      it 'win down / left' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        3.times { n| game.grid[n][n] = '🔵' }
        3.times { n| game.grid[n][n] = '🔵' }
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'win down / right' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'win up / left' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end

      it 'win up / right' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        expect(game.game_over?).to be_truthy
        puts game.display_board
      end
    end

    context 'returns false if no one has won:' do
      it '3 inputs' do
        game = ConnectFour.new('Bruno', 1, 'Giu', 2)
        3.times { |n| game.input(n + 1) }
        expect(game.game_over?).to_not be_truthy
        puts game.display_board
      end
    end
  end
end
