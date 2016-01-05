WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board (board)
  puts" #{board[0]} | #{board[1]} | #{board[2]} "
  puts"-----------"
  puts" #{board[3]} | #{board[4]} | #{board[5]} "
  puts"-----------"
  puts" #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, character = "X")
  location = position.to_i - 1
  board[location] = character
  display_board(board)
end

def position_taken?(board, location)
  if board[location] == " "
    false
  elsif board[location] == ""
    false
  elsif board[location] == nil
    false
  else
    true
  end
end

def valid_move?(board, position)
  location = position.to_i - 1
  if location.between?(0, 8) && !position_taken?(board, location)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  move = gets.strip

  while !valid_move?(board, move)
    puts "Please enter a value thats not taken:"
    move = gets.strip
  end
    move(board, move, current_player(board))
end

def turn_count(board)
  turn_number = board.count("X") + board.count("O")
end

def current_player(board)
  if turn_count(board) == 0 || turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end 

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    x = combination.map do |space|
      board[space]
    end

    return combination if x.count("X") == 3 || x.count("O") == 3

  end
  return false
end

def full?(board)
  if board.count("X") + board.count("O") == 9
    true
  else
    false
  end
end

def draw?(board)
  if won?(board)
    false
  elsif full?(board)
    true
  else
    false
  end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board)
    true
  else
    false
  end
end

def winner(board)
  return puts "Cats Game!" unless won?(board)

  combination = won?(board)
   winning = combination.map do |space|
     board[space]
   end

  if winning.count("X") == 3
     puts "Congratulations X!"
     "X"
  else winning.count("O") == 3
     puts "Congratulations O!"
     "O"
  end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  
  winner(board)
end