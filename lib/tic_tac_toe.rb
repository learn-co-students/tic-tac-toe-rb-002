WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [6,4,2]
  ]

# Displays the Board using the Array values of board[]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Loops through playing 9 rounds (total spaces)
def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end

# Asks for input, calls for validity chack, and calls move
def turn(board)
  puts "Player (#{current_player(board)}) - Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

# Checks if the input provided is valid, between 1&9 and calls position taken
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

# Checks to see if selected location is already taken, or open to play
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# Places token for current player in the selected loaction
def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

# Current player defined by how many turns have occured
def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Counts turns played
def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

# Checks board against winning combos
def won?(board)
  WIN_COMBINATIONS.detect do |combo|
   board[combo[0]] == board[combo[1]] &&
   board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

# Checks for a draw game - full board without winner
def draw?(board)
  !won?(board) && full?(board)
end

# Checks if the board is filled completely with X or O
def full?(board)
  board.all?{|token| token == "X" || token =="O"}
end

# Returns winner
def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end

# Checks to see if the game is over - either a win or draw
 def over?(board)
     if draw?(board) || won?(board)
    true
  else
    false
  end
end