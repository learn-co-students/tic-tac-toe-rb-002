# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # \
  [6,4,2]  # /
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, pos, token = "X")
  board[pos.to_i-1] = token
end

def position_taken?(board, pos)
  board[pos] == "X" || board[pos] == "O" #i felt this was a better way to address edge case scenarios than what the readme suggested
end

def valid_move?(board, pos)
  pos.to_i.between?(1, board.length) && !position_taken?(board, pos.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip
  while !valid_move?(board, position)
    puts "Input invalid. Please select an empty sapce by inputting an integer between 1 and 9"
    position = gets.strip
  end
  move(board, position, current_player(board))
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |token|
    count += 1 if token == "X" || token == "O"
  end
  return count
end

def current_player(board)
  turn_count(board).odd? ? "O" : "X"
end

# Define #won? method that returns the winning combination of the board argument
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    # win_combo is a 3 element array of indexes that compose a win, [0,1,2]
    if (board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X") || (board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O")
      return win_combo # return the win_combo indexes that won.
    end
  end
  false
end

# Define #full? method that determines returns true for a full board
def full?(board)
  board.all? do |token|
    token == "X" ||  token == "O"
  end
end

# Define #draw? method that returns true for a full board without a winning combination
def draw?(board)
  full?(board) && !won?(board)
end

# Define #over? method that returns true if there is a winning combo, draw, or full board
def over?(board)
  #   won?(board).class == Array || draw?(board) || full?(board) # this causes rspec to hang at 'checks if the game is won after every turn'
  won?(board) || draw?(board) || full?(board)
end

# Define #winner method that returns the token of the winning combo, "X" or "O"
def winner(board)
  win_combo = won?(board)
  if win_combo
    return board[win_combo[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end