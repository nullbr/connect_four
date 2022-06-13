require './lib/connect_four'
require 'yaml'

gemfile true do
  source 'http://rubygems.org'
  gem 'ruby_figlet'
end

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
  saved_games = Dir.entries('saved')[2..]

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

if Dir.exist?('saved') && Dir.entries('saved').size > 2
  puts "0: to start a new game \n1: to load a game"
  choice = get_input([0, 1])
else
  choice = 0
end

# Start a new game
if choice.zero?
  puts "\nName for Player 1"
  player1 = gets.chomp

  puts "\nPick a color"
  colors.each_with_index { |color, idx| puts "#{idx}: #{color}" }
  color1 = gets.chomp.to_i

  puts "\nPlayer 2"
  player2 = gets.chomp

  puts "\nPick a color"
  colors.each_with_index { |color, idx| puts "#{idx}: #{color}" unless color1 == idx }
  color2 = gets.chomp.to_i

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
