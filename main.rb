require './lib/connect_four'
require 'ruby_figlet'

using RubyFiglet # For String.new(...).art / .art! Moneky Patches

colors = ['⚪', '🔵', '🟡', '🟢', '🟣', '🟤']

puts 'Connect Four'.art


puts "\nLets Play!"
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
system 'clear'

game = ConnectFour.new(player1, color1, player2, color2)

puts game.display_board

until game.game_over?
  puts "\n#{game.current_player[:name]}, choose a column"
  game.input(gets.chomp.to_i)
  game.next_player
  system 'clear'
  puts game.display_board
end

puts 'Game Over!'
puts "#{game.next_player[:name]} won!"
