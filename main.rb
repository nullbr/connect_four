require_relative '.bundle/ruby/2.5.0/gems/ruby_figlet-0.6.1/lib/ruby_figlet'
require_relative 'lib/processing'
require_relative 'lib/connect_four'

using RubyFiglet # For String.new(...).art / .art! Moneky Patches

colors = ['⚪', '🔵', '🟡', '🟢', '🟣', '🟤']
processing = Processing.new

puts 'Connect Four'.art

puts "\nLets Play!"

puts "\nRules:\n"\
  "\nThe goal is to connect 4 dots of the same color inline"\
  "\neither horizontally, vertically or diagonally\n"\
  "\nType end or quit to exit the game.\n"\
  "\nThe game will be saved automatically as soon as the first person plays.\n"\
  "\nHave fun!"

puts '---------'
if Dir.exist?('saved') && Dir.entries('saved').size > 2
  puts "0: to start a new game \n1: to load a game"
  choice = processing.get_input([0, 1])
else
  choice = 0
end

# Start a new game
if choice.zero?
  puts "\nName for Player 1"
  player1 = processing.get_input

  puts "\nPick a color"
  color_options = [0, 1, 2, 3, 4, 5]
  colors.each_with_index { |color, idx| puts "#{idx}: #{color}" }
  color1 = processing.get_input(color_options)

  color_options.delete(color1)

  puts "\nPlayer 2"
  player2 = processing.get_input

  puts "\nPick a color"
  colors.each_with_index { |color, idx| puts "#{idx}: #{color}" unless idx == color1 }
  color2 = processing.get_input(color_options)

  game = ConnectFour.new(player1, color1, player2, color2)
  system 'clear'
  puts game.display_board

  # Set new file to be used for saving the game
  time = Time.now.strftime('%Hh%M-%d-%m-%Y')
  filename = "saved/#{player1}-#{player2}-#{time}.yaml"

# Load a game from saved games
else
  filename = processing.choose_saved_game { |game_options| processing.get_input(game_options) }
  filename = "saved/#{filename}"
  game = processing.load_game(filename)

  system 'clear'
  puts game.display_board
end

until game.game_over?
  puts "\n#{game.current_player[:name]}, choose a column"
  columns = []
  8.times { |n| columns << n + 1 if game.input_valid?(n + 1) }
  input = processing.get_input(columns)
  system 'clear'

  game.input(input)
  puts game.display_board
  game.next_player

  processing.save_game(game, filename)
end

File.delete(filename) if File.exist?(filename)
puts 'Game Over!'
puts "#{game.next_player[:name]} won!"
