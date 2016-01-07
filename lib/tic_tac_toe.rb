def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def move(board, location, player = "X")
  if turn_count(board) == 0
    board[location.to_i-1] = player
  else player = current_player(board)
    board[location.to_i-1] = player
  end
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

def turn_count(board)
  board.count("X") + board.count("O")
end

def current_player(board)
  if turn_count(board) == 1 && board.include?("O")
    turn_count(board).even? ? ("O") : ("X")
  else
    turn_count(board).even? ? ("X") : ("O")
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0] #[0, 3, 6, 0, 1, 2, 0, 3]
    win_index_2 = win_combination[1] #[1, 4, 7, 3, 4, 5, 4, 4]
    win_index_3 = win_combination[2] #[2, 5, 8, 6, 7, 8, 8, 6]

    # board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
    # board = [" ", " ", " ", "X", "X", "X", " ", " ", " "]
    # board = ["O", " ", " ", "O", " ", " ", "O", " ", " "]

    position_1 = board[win_index_1] #board[0, 3, 6, 0, 1, 2, 0, 3]
    position_2 = board[win_index_2] #board[1, 4, 7, 3, 4, 5, 4, 4]
    position_3 = board[win_index_3] #board[2, 5, 8, 6, 7, 8, 8, 6]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  false
end

def full?(board)
  if board.count{|pos| pos == "X" || pos == "O"} == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  elsif !won?(board) && !full?(board) || won?(board)
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  
  if winner(board) == "X"
    puts "Congratulations X!"
   elsif winner(board) == "O"
    puts "Congratulations O!"
   else
    puts "Cats Game!"
  end
end