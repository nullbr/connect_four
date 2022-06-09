class ConnectFour
  COLORS = ['⭕', '⚪', '🔵', '🟡', '🟢', '🟣', '🟤'].freeze

  attr_reader :game
  
  # initialize players with their color choices and build game
  def initialize(player1, color1, player2, color2)
    @player1 = { name: player1, color: COLORS[color1] }
    @player2 = { name: player2, color: COLORS[color2] }
    @game = build_game
    @current_player = @player1
  end

  # Returns the game grid
  def display_board
    board = "   1 2 3 4 5 6 7 8\n"
    count = 6
    while count.positive?
      board += "#{count} #{@game[count - 1].join}\n"
      count -= 1
    end
    "#{board}   1 2 3 4 5 6 7 8"
  end

  # Initialize the array of arrays containg all spots in the grid
  def build_game
    @game = []
    6.times do |i|
      @game << []
      8.times { @game[i] << '⭕' }
    end
    @game
  end
end
