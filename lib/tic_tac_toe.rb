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

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#----

def move(array, input, character="X")
  location = input.to_i
  newloc = location-1
  array[newloc] = character
end

#----

def position_taken?(board, position)
  if board[position] == "X" || board[position] == "O"
    return true
  else
    return false
  end
end

#----

def valid_move?(board, position_string)
  position=position_string.to_i
  if (position < 1 || position > 9) || position_taken?(board, position-1)
    return false
  else
    return true
  end
end

#----

def turn(board)
  invalid = true
  while invalid == true
    puts "Please enter a move 1-9:"
    input = gets.strip
    if valid_move?(board, input)
      invalid = false
    end
  end
  move(board, input, current_player(board))
  display_board(board)
end

#----

def turn_count(board)
  count = 0
   board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
   end
  return count
end

#puts turn_count(board).to_s

#----

def current_player(board)
  if turn_count(board) % 2 == 1
    return "O"
  else
    return "X"
  end
end

#----

def won?(board)
  winning_set = nil
  won = false
  counter = 0
  position = ["", "", ""]

  WIN_COMBINATIONS.each do |i|
    counter = 0
    i.each do |m|
      position[counter] = board[m]
      counter += 1
    end
   if (position[0] == "X" && position[1] == "X" && position[2] == "X") ||
      (position[0] == "O" && position[1] == "O" && position[2] == "O")
         won = true
    end
    if won
      winning_set = i
      break
    end
  end

  if won
    #puts 'winning_set = ' + winning_set.to_s
    return winning_set
  else return false
  end
end

#----

def full?(board)
  full_board = true
  board.each do |i|
    if !(i == "X" || i == "O")
      full_board = false
    end
  end
  #puts 'full_board = ' + full_board.to_s
  return full_board
end

#----

def draw?(board)
  #returns true if the board has not been won and is full
  #false if the board is not won and the board is not full
  #false if the board is won.
  if won?(board)
    return false
  end
  if full?(board)
    return true
  else
    return false
  end
end

#----

def over?(board)
  #returns true if the board has been won,
  #is a draw,
  #or is full
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

#----

def winner(board)
  winner = won?(board)
  #puts "winner = " + winner.to_s
  if winner
    return board[winner[0]]
  else
    return nil
  end
end

#----

def play(board)
  while !over?(board) do
    turn(board)
  end
  if winner(board)
    puts "Congratulations " + winner(board) + "!"
    elsif draw?(board)
    puts "Cats Game!"
  end
end





