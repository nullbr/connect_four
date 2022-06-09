class ConnectFour
  COLORS = ['⭕', '⚪', '🔵', '🟡', '🟢', '🟣', '🟤'].freeze

  def initialize(player1, color1, player2, color2)
    @player1 = { name: player1, color: COLORS[color1] }
    @player2 = { name: player2, color: COLORS[color2] }
  end

  def display_board
    "   1 2 3 4 5 6 7 8\n"\
    "6 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
    "5 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
    "4 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
    "3 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
    "2 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
    "1 ⭕⭕⭕⭕⭕⭕⭕⭕\n"\
    '   1 2 3 4 5 6 7 8'
  end
end
