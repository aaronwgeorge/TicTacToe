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

#method to make sure a square is empty
def square_empty?(current_value)
  if current_value == "X" || current_value == "O"
    false
  else
    true
  end
end

#check for winner(1,2,3);(4,5,6);(7,8,9);(1,4,7);(2,5,8);(3,6,9);(1,5,9);(3,5,7)
def winner?(hash)
  if hash[1] == "X" && hash[2] == "X" && hash[3] == "X"
    p "You Win!"
  elsif hash[1] == "O" && hash[2] == "O" && hash[3] == "O"
    p "You Lose!"
  elsif hash[4] == "X" && hash[5] == "X" && hash[6] == "X"
    p "You Win!"
  elsif hash[4] == "O" && hash[5] == "O" && hash[6] == "O"
    p "You Lose!"
  elsif hash[7] == "X" && hash[8] == "X" && hash[9] == "X"
    p "You Win!"
  elsif hash[7] == "O" && hash[8] == "O" && hash[9] == "O"
    p "You Lose!"
  elsif hash[1] == "X" && hash[4] == "X" && hash[7] == "X"
    p "You Win!"
  elsif hash[1] == "O" && hash[4] == "O" && hash[7] == "O"
    p "You Lose!"
  elsif hash[2] == "X" && hash[5] == "X" && hash[8] == "X"
    p "You Win!"
  elsif hash[2] == "O" && hash[5] == "O" && hash[8] == "O"
    p "You Lose!"
  elsif hash[3] == "X" && hash[6] == "X" && hash[9] == "X"
    p "You Win!"
  elsif hash[3] == "O" && hash[6] == "O" && hash[9] == "O"
    p "You Lose!"
  elsif hash[1] == "X" && hash[5] == "X" && hash[9] == "X"
    p "You Win!"
  elsif hash[1] == "O" && hash[5] == "O" && hash[9] == "O"
    p "You Lose!"
  elsif hash[3] == "X" && hash[5] == "X" && hash[7] == "X"
    p "You Win!"
  elsif hash[3] == "O" && hash[5] == "O" && hash[7] == "O"
    p "You Lose!"
  else
    false
  end
end

#check if all squares are filled
def all_squares_filled?(hash)
  if hash.values.include?(" ")
    false
  else
    p "Game Over! Cat's Game :)" 
  end
end

#create hash to store data for all the squares on the gameboard
squares = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}

#initialize gameplay
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "Let's play Tic Tac Toe!!"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "You go first. Choose a square to place an X."
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

#start game loop

loop do
  
  draw_board(squares)

  #ask for user input - pick square 1-9
  puts "Pick a square (1-9):"
  player_choice = gets.chomp.to_i

  #check board to see if square is empty
  until square_empty?(squares[player_choice]) do
    puts "That square is already taken. Try again:"
    player_choice = gets.chomp.to_i
  end
    
  #update hash with user choice and add to board
  squares[player_choice] = "X"

  draw_board(squares)

  break if winner?(squares) || all_squares_filled?(squares)

  puts "Computer thinking..."
  sleep(1)

  #computer randomly chooses a square
  comp_choice = squares.keys.sample

  #check board to see if square is empty
  until square_empty?(squares[comp_choice]) do
    comp_choice = squares.keys.sample
  end

  #update hash with comp choice and add to board
  squares[comp_choice] = "O"
  
  break if winner?(squares) || all_squares_filled?(squares)

end 
