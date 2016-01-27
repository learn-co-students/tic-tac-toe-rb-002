# Define your WIN_COMBINATIONS constant - all the possible three-location wins!
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # diag top left to bottom right
  [6,4,2]] # diag top right to bottom left


# code your #display_board method to show the state of the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} " 
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your #move method to ask for the user choice
def move(board, location, token = "X")
  #this sets the correct index value of the chosen position on the board equal to the token 
  #(i.e., puts an X or O where you chose, if valid)
  board[location.to_i-1]= token
end

# code your #position_taken? method here, so that it can assist the #valid_move? method
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# code your #valid_move? method here to see if the user selection is OK to make
def valid_move?(board, location)
  location.to_i.between?(1,9) && !position_taken?(board, location.to_i-1)
end

#code your #turn method to ask the user for their location choice
def turn(board)
  puts "Please enter 1-9:"
  location = gets.strip
  if valid_move?(board, location)
      token = current_player(board) #This was not clear in the instructions on how to get the correct token
      move(board, location, token)
  else
    turn(board)
  end
  display_board(board)
end

# code your #turn_count method that returns the number of turns that have been played
def turn_count(board)
  turn_counter = 0
  board.each do |location|
    if location == "X" || location == "O"
      turn_counter += 1
    end
  end
  turn_counter
end

#code #current_player method that uses the #turn_count method to return which player gets to move
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# define your #won? method to test if any of the WIN_COMBINATIONS has been matched
  def won?(board)
    WIN_COMBINATIONS.detect do |wc|
      board[wc[0]] == board[wc[1]] && board[wc[1]] == board [wc[2]] && position_taken?(board, wc[0])
    end  
  end

# define your #full? method to see if the board has all locations taken
def full?(board)
  board.all? do |location| 
    location == "X" || location == "O"
  end
end

# define your #draw? method, which checks to see if the board is full and/or won
def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

# define #over? method to see if the game is over based on a win or draw
def over?(board)
  won?(board) || draw?(board) || full?(board)
end

# define #winner method to determine based on the WIN_COMBINATION which of "X" or "O" won the game
def winner(board)
  if winning_token = won?(board)
    board[winning_token[0]]
  end
end

# code your #play method here
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    if winner(board) == "X"
      puts "Congratulations X!"
    else
      puts "Congratulations O!"
    end
  else
    puts "Cats Game!"
  end
end

