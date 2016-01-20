# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # bottom row
  [0,4,8],  # top left to bottom right win
  [6,4,2],  # top right to bottom left win
  [0,3,6],   # first col
  [1,4,7],  # second col
  [2,5,8]   # third col
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = current_player(board))
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input)
  else
    turn(board)
  end
  display_board(board)

end

def play(board)

  while over?(board) == false
    turn(board)
  end
  if winner(board) == "X"
      puts "Congratulations X!"
  elsif winner(board) == "O"
      puts "Congratulations O!"
  elsif draw?(board) == true
      puts "Cats Game!"
   end
end
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


def winner(board)
  if board[0] == "X" && board[1] == "X" && board[2] == "X"
     "X"
  elsif board[3] == "X" && board[4] == "X" && board[5] == "X"
      "X"
  elsif board[6] == "X" && board[7] == "X" && board[8] == "X"
     "X"
  elsif board[0] == "X" && board[3] == "X" && board[6] == "X"
    "X"
  elsif board[1] == "X" && board[4] == "X" && board[7] == "X"
    "X"
  elsif board[2] == "X" && board[5] == "X" && board[8] == "X"
    "X"
  elsif board[0] == "X" && board[4] == "X" && board[8] == "X"
    "X"
  elsif board[2] == "X" && board[4] == "X" && board[6] == "X"
    "X"
  elsif board[0] == "O" && board[1] == "O" && board[2] == "O"
    "O"
  elsif board[3] == "O" && board[4] == "O" && board[5] == "O"
    "O"
  elsif board[6] == "O" && board[7] == "O" && board[8] == "O"
    "O"
  elsif board[0] == "O" && board[3] == "O" && board[6] == "O"
    "O"
  elsif board[1] == "O" && board[4] == "O" && board[7] == "O"
    "O"
  elsif board[2] == "O" && board[5] == "O" && board[8] == "O"
    "O"
  elsif board[0] == "O" && board[4] == "O" && board[8] == "O"
    "O"
  elsif board[2] == "O" && board[4] == "O" && board[6] == "O"
    "O"
  else
    return nil
  end
end
def over?(board)
  if draw?(board) == true
    return true
  elsif won?(board) != false
    return true
  else
    return false
  end
end
def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  else
    return false
  end
end
def full?(board)
  if board[0] != " " && board[1] != " " && board[2] != " " && board[3] != " " && board[4] != " " && board[5] != " " && board[6] != " " && board[7] != " " && board[8] != " "
    return true
  else
    return false
  end
end
def won?(board)
  if board[0] == "X" && board[1] == "X" && board[2] == "X"
     winX =[0,1,2]
  elsif board[3] == "X" && board[4] == "X" && board[5] == "X"
    winX =[3,4,5]
  elsif board[6] == "X" && board[7] == "X" && board[8] == "X"
     winX =[6,7,8]
  elsif board[0] == "X" && board[3] == "X" && board[6] == "X"
    winX = [0,3,6]
  elsif board[1] == "X" && board[4] == "X" && board[7] == "X"
    winX = [1,4,7]
  elsif board[2] == "X" && board[5] == "X" && board[8] == "X"
    winX = [2,5,8]
  elsif board[0] == "X" && board[4] == "X" && board[8] == "X"
    winX = [0,4,8]
  elsif board[2] == "X" && board[4] == "X" && board[6] == "X"
    winX = [2,4,6]
  elsif board[0] == "O" && board[1] == "O" && board[2] == "O"
    wonO =[0,1,2]
  elsif board[3] == "O" && board[4] == "O" && board[5] == "O"
    winO =[3,4,5]
  elsif board[6] == "O" && board[7] == "O" && board[8] == "O"
    winO =[6,7,8]
  elsif board[0] == "O" && board[3] == "O" && board[6] == "O"
    winO = [0,3,6]
  elsif board[1] == "O" && board[4] == "O" && board[7] == "O"
    winO = [1,4,7]
  elsif board[2] == "O" && board[5] == "O" && board[8] == "O"
    winO = [2,5,8]
  elsif board[0] == "O" && board[4] == "O" && board[8] == "O"
    winO = [0,4,8]
  elsif board[2] == "O" && board[4] == "O" && board[6] == "O"
    winO = [2,4,6]
  else
    return false
  end
end
def turn_count(board) # counts positions taken
  turns = 0
  board.each do |square| # looks at all board positions
    if square == "X" || square == "O" # checks for and X or O in each board position
      turns += 1 # for each O or X founds increases turn count
    end
  end
  return turns
end


def current_player(board) # finds current player
  turn = turn_count(board) # calls #turn_counter
  if turn % 2 == 0 # if turn is even
    "X"
  else # if turn is odd
    "O"
  end
end