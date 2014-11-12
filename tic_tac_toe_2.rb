require "pry"

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

#method to draw gameboard to be filled in by players
def draw_board(hash)
  system "clear"
  puts "       |       |"
  puts "   #{hash[1]}   |   #{hash[2]}   |   #{hash[3]}   "
  puts "       |       |"
  puts "-------+-------+-------"
  puts "       |       |"
  puts "   #{hash[4]}   |   #{hash[5]}   |   #{hash[6]}   "
  puts "       |       |"
  puts "-------+-------+-------"
  puts "       |       |"
  puts "   #{hash[7]}   |   #{hash[8]}   |   #{hash[9]}   "
  puts "       |       |"
end

#method to find all empty squares, returned in array
def empty_squares(board)
  board.select {|k,v| v == " "}.keys
end

#check for winner
def there_is_a_winner(board)
  WINNING_LINES.each do |l|
    if board.values_at(l[0], l[1], l[2]) == ["X", "X", "X"]
      puts "YOU WIN!!"
      true
    elsif board.values_at(l[0], l[1], l[2]) == ["O", "O", "O"]
      puts "YOU LOSE!!"
      true
    else
      false
    end
  end
end

#check if all squares are filled
def all_squares_filled?(hash)
  if hash.values.include?(" ")
    false
  else
    puts "Game Over! Cat's Game :)"
    true
  end
end

def player_turn(board)
  puts "Select a square (from 1-9):"
  choice = gets.chomp.to_i
  
  until empty_squares(board).each {|i| i == choice} do
    puts "Try again. Squares #{empty_squares(board)} are available:"
    choice = gets.chomp.to_i
  end

  board[choice] = "X"
end 

def comp_turn(board)

  #see if comp can attack
  #if not, see if comp needs to defend
  #if not, select a random square

end

#create hash to store data for all the squares on the gameboard
squares = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}

#start game loop

loop do
  
  draw_board(squares)

  player_turn(squares)

  draw_board(squares)

  binding.pry

  break if there_is_a_winner(squares) || all_squares_filled?(squares)

  puts "Computer thinking..."
  sleep(1.5)

  #computer randomly chooses a square
  comp_choice = empty_squares(squares).sample

  squares[comp_choice] = "O"
  
  break if there_is_a_winner(squares) || all_squares_filled?(squares)

end 
