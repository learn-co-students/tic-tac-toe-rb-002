# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  ]

def play(board)
  until over?(board) do
    turn(board)
  end
puts winner(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"


=begin
  until the game is over
  take turns
end

if the game was won
  congratulate the winner
else if the game was a draw
  tell the players it has been a draw
end
=end
end

# Define display_board that accepts a board and prints
# out the current state.
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, character = "X")
  location = location.to_i
  board[location - 1] = character #Update the board
  return board
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, position)
  arrayposition = position.to_i - 1
  if arrayposition.between?(0, 8) && position_taken?(board, arrayposition) == false
    return true
  else
    return false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    puts "Error -- Please enter 1-9:"
    input = gets
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  # Compare each winning combo to the board to see if someone won.
  WIN_COMBINATIONS.each do |winning_combo|
    if board[winning_combo[0]] == "X" && board[winning_combo[1]] == "X" && board[winning_combo[2]] == "X"
      return winning_combo
    elsif board[winning_combo[0]] == "O" && board[winning_combo[1]] == "O" && board[winning_combo[2]] == "O"
      return winning_combo
    end
  end
  # Well, I guess there weren't any wins if you made it out the loop.
  return false
end

def full?(board)
  #Are all the spaces full?
  filledSpace = 0
  board.each do |space|
    if space == "X" || space == "O"
      filledSpace += 1
    end
  end
  # If all 9 spaces are full, return true, otherwise false
  filledSpace == 9 ? true : false
end

def draw?(board)
  # Is the board full and not won?
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  # Is the game a draw? or won?
  draw?(board) || won?(board) ? true : false
end

def winner(board)
  if won?(board)
    playerwinning = won?(board)
    if board[playerwinning[0]] == "X"
      return "X"
    elsif board[playerwinning[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end
