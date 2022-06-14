require 'yaml'

class Processing
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
    Psych.safe_load(loaded_game, [ConnectFour, Symbol], [], true)
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
end
