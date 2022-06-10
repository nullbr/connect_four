class ConnectFour
  COLORS = ['⚪', '🔵', '🟡', '🟢', '🟣', '🟤'].freeze
  H_CIRCLE = '⭕'.freeze

  attr_accessor :grid
  attr_reader :current_player

  # initialize players with their color choices and build game
  def initialize(player1, color1, player2, color2)
    @player1 = { name: player1, color: COLORS[color1] }
    @player2 = { name: player2, color: COLORS[color2] }
    @grid = build_grid
    @current_player = @player1
  end

  # Returns the game grid
  def display_board
    board = " 1 2 3 4 5 6 7 8\n"
    count = 6
    while count.positive?
      board += "#{@grid[count - 1].join}\n"
      count -= 1
    end
    "#{board} 1 2 3 4 5 6 7 8"
  end

  # Initialize the array of arrays containg all spots in the grid
  def build_grid
    @grid = []
    6.times do |i|
      @grid << []
      8.times { @grid[i] << H_CIRCLE }
    end
    @grid
  end

  # Takes position x and y, and inputs it in the board
  def input(x)
    return unless input_valid?(x)

    @last_input = input_where(x)
    @grid[@last_input[0]][@last_input[1]] = @current_player[:color]
  end

  # Check if input to grid is valid
  def input_valid?(x)
    # Input in the grid limits?
    x.between?(1, 8) && @grid[5][x - 1] == H_CIRCLE
  end

  # takes the last input and check if it caused the game to end
  def game_over?
    horizontally?
  end

  def next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  private

  # a index x and input into row the correct row
  def input_where(x)
    return [0, x - 1] if @grid[0][x - 1] == H_CIRCLE

    position = []
    @grid.each_with_index do |row, idx|
      next if idx.zero?

      if row[x - 1] == H_CIRCLE
        position = [idx, x - 1]
        break
      end
    end
    position
  end

  def horizontally?
    y = @last_input[0]
    x = @last_input[1]
    check_left(x, y) || check_right(x, y)
  end

  def check_right(x, y)
    colors = []
    3.times { |n| colors << @grid[y][x + n + 1] }
    puts colors
    colors.all? { |color| color == @current_player[:color] }
  end

  def check_left(x, y)
    colors = []
    3.times { |n| colors << @grid[y][x - n - 1] }
    puts colors
    colors.all? { |color| color == @current_player[:color] }
  end
end