def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Helper Method
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def full?(board)
  !board.include?(" ") #if there is an empty space, then not full
end

# Define your WIN_COMBINATIONS constant

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]

  # ETC, an array for each win combination
]

def won?(board)
  for win_combo in WIN_COMBINATIONS
    position1 = board[win_combo[0]]
    position2 = board[win_combo[1]]
    position3 = board[win_combo[2]]
    if position1 == position2 && position2 == position3 && position1 != " "
      return win_combo
    end
  end
  return false
end

def draw?(board)
  return !won?(board) && full?(board)
end

def over?(board)
  return won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def move(board, location, character="X")
  board[location-1] = character
end

def valid_move?(board, position)
  position = position.to_i
  return position >= 1 && position <= 9 && !position_taken?(board, position-1)
end

def turn(board)
  puts "Enter a move"
  input = gets.chomp.to_i
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  return 9 - board.count(" ")
end

def current_player(board)
  if board.count("O") < board.count("X")
    return "O"
  else
    return "X"
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end

  champion = winner(board)
  if champion
    puts "Congratulations #{champion}!"
  else
    puts "Cats Game!"
  end

end


