require "pry"

#possible ways to win stored in arrays
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
def there_is_a_winner?(board)
  WINNING_LINES.each do |l|
    if board.values_at(l[0], l[1], l[2]) == ["X", "X", "X"]
      puts "YOU WIN!!"
      return true
    elsif board.values_at(l[0], l[1], l[2]) == ["O", "O", "O"]
      puts "YOU LOSE!!"
      return true
    end
  end
  false
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

#method for player's turn
def player_turn(board)
  puts "Select a square (from 1-9):"
  choice = gets.chomp.to_i
  
  until empty_squares(board).include?(choice)
    puts "Try again. Squares #{empty_squares(board)} are available:"
    choice = gets.chomp.to_i
  end

  board[choice] = "X"
end 

#find out if there are two X's or O's in a row so computer makes smart moves
def two_in_a_row?(hash, marker)
  if hash.values.count(marker) == 2
    hash.select {|k, v| v == " "}.keys.first
  else
    false
  end
end

#method for comp's turn
def comp_turn(board)

  puts "Computer thinking..."
  sleep(1.5)

  attack_square = nil
  defend_square = nil
  attacked = nil
  defended = nil
  
  #attack if possible
  WINNING_LINES.each do |l|
    attack_square = two_in_a_row?({l[0] => board[l[0]], l[1] => board[l[1]], l[2] => board[l[2]]}, "O") 
    if attack_square
      board[attack_square] = "O"
      attacked = true
      break
    end
  end

  #if cannot attack, then check for defend
  if !attacked
    WINNING_LINES.each do |l|
      defend_square = two_in_a_row?({l[0] => board[l[0]], l[1] => board[l[1]], l[2] => board[l[2]]}, "X")
      if defend_square 
        board[defend_square] = "O"
        defended = true
        break
      end
    end
  end

  #if can't defend, select a random square
  if !attacked && !defended
    comp_choice = empty_squares(board).sample
    board[comp_choice] = "O"
  end

end    

#start game loop

play_again = "Y"

while play_again == "Y" do
  
  #create hash to store data for all the squares on the gameboard
  squares = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
  
  loop do
    
    draw_board(squares)
    
    player_turn(squares)

    draw_board(squares)

    break if there_is_a_winner?(squares) || all_squares_filled?(squares)

    comp_turn(squares)

    draw_board(squares)
  
    break if there_is_a_winner?(squares) || all_squares_filled?(squares)

  end

  puts "Play again? (Y/N)"
  play_again = gets.chomp.upcase

end
