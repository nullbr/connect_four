require './lib/connect_four'


colors = ['⚪', '🔵', '🟡', '🟢', '🟣', '🟤']

puts "Player 1"
player1 = gets.chomp
system 'clear'

puts "Pick a color"
p colors
color1 = gets.chomp.to_i
system 'clear'

puts "Player 2"
player2 = gets.chomp
system 'clear'

puts "Pick a color"
p colors
color2 = gets.chomp.to_i
system 'clear'

game = ConnectFour.new(player1, color1, player2, color2)

puts game.display_board

puts game.game_over?

while !game.game_over?
    puts "#{game.current_player[:name]} choose a column"
    game.input(gets.chomp.to_i)
    game.next_player
    system 'clear'
    puts game.display_board
    first_play = false
end

puts 'Game Over!'