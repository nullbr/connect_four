require './lib/connect_four'
require 'yaml'
require_relative '.bundle/ruby/2.5.0/gems/ruby_figlet-0.6.1/lib/ruby_figlet.rb'

def save_game(game, filename)
  Dir.mkdir('saved') unless Dir.exist?('saved')
  dumpfile = Psych.dump(game)
  File.write(filename, dumpfile)
end

# Choose from saved games, return filename if exists, return nil if it does not
def choose_saved_game
  puts 'Getting saved games...'
  options = []
  puts 'Choose from saved games: '
  saved_games = Dir.entries('saved')[2..-1]

  saved_games.each_with_index do |filename, idx|
    puts "#{idx}: #{filename}"
    options << idx
  end
  choose_file = yield(options)
  saved_games[choose_file]
end

def load_game(filename)
  loaded_game = File.open(filename)
  Psych.safe_load(loaded_game, aliases: true, permitted_classes: [ConnectFour, Symbol])
end

def get_input(options = ' ')
  yield if block_given?
  while true
    input = gets.chomp.strip
    if %w[quit end exit].include?(input.downcase)
      puts 'Your game was saved,'
      abort('Exiting the game...')

    # Check if theres only letters in the string if options are string
    elsif options == ' ' && input.match?(/^[[:alpha:]]+$/)
      break

    # Check if string only contains an integer and its the correct type
    elsif !(options == ' ') && input !~ /\D/
      input = input.to_i
      options.include?(input) ? break : (print "Options are #{options} ")

    # Ask for a valid input type
    else
      print "Enter a valid #{options[0].class}. "
    end
  end
  input
end

using RubyFiglet # For String.new(...).art / .art! Moneky Patches

colors = ['⚪', '🔵', '🟡', '🟢', '🟣', '🟤']

puts 'Connect Four'.art

puts "\nLets Play!"

puts "\nRules:\n"\
  "\nThe goal is to connect 4 dots of the same color inline"\
  "\neither horizontally, vertically or diagonally\n"\
  "\nType end or quit to exit the game.\n"\
  "\nThe game will be saved automatically as soon as the first person plays.\n"\
  "\nHave fun!"

puts "---------"
if Dir.exist?('saved') && Dir.entries('saved').size > 2
  puts "0: to start a new game \n1: to load a game"
  choice = get_input([0, 1])
else
  choice = 0
end

# Start a new game
if choice.zero?
  puts "\nName for Player 1"
  player1 = get_input

  puts "\nPick a color"
  options = [0, 1, 2, 3, 4, 5]
  colors.each_with_index { |color, idx| puts "#{idx}: #{color}" }
  color1 = get_input(options)
  
  options.delete(color1)

  puts "\nPlayer 2"
  player2 = get_input

  puts "\nPick a color"
  colors.each_with_index { |color, idx| puts "#{idx}: #{color}" unless idx == color1 }
  color2 = get_input(options)

  game = ConnectFour.new(player1, color1, player2, color2)
  system 'clear'
  puts game.display_board

  # Set new file to be used for saving the game
  time = Time.now.strftime('%Hh%M-%d-%m-%Y')
  filename = "saved/#{player1}-#{player2}-#{time}.yaml"

# Load a game from saved games
else
  filename = choose_saved_game { |options| get_input(options) }
  filename = "saved/#{filename}"
  game = load_game(filename)

  system 'clear'
  puts game.display_board
end

until game.game_over?
  puts "\n#{game.current_player[:name]}, choose a column"
  input = get_input([1, 2, 3, 4, 5, 6, 7, 8])
  system 'clear'

  next unless game.input_valid?(input)

  game.input(input)
  puts game.display_board
  game.next_player

  save_game(game, filename)
end

File.delete(filename) if File.exist?(filename)
puts 'Game Over!'
puts "#{game.next_player[:name]} won!"
