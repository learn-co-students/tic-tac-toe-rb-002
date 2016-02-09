WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def move(array, position, value = "X")
  array[position.to_i-1] = value
end
def position_taken?(board, position)
  position = position.to_i
  if board[position] == " "
    return false
  elsif board[position] == ""
    return false
  elsif board[position] == nil
    return false
  elsif board[position] == "X"
    return true
  elsif board[position] == "O"
    return true
  end
end
def valid_move?(board,position)
  position = position.to_i
  position = position - 1
  if position.between?(0,8) && !position_taken?(board, position)
      return true
  else
    return false
  end
end
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input) == true
    value = current_player(board)
    move(board, input, value)
    display_board(board)
  else
    puts "Invalid input. Please try again."
    display_board(board)
    turn(board)
  end
end
def turn_count(board)
  counter = 0
  board.each do |position|
    if position != " "
      counter = counter + 1
    end
  end
  return counter
end
def current_player(board)
  if turn_count(board) % 2 != 0
    return "O"
  else
    return "X"
  end
end
def won?(board)
  WIN_COMBINATIONS.each do |combo|
    win_index1 = combo[0]
    win_index2 = combo[1]
    win_index3 = combo[2]
    array_1 = [board[win_index1], board[win_index2], board[win_index3]]
    if array_1 == ["X","X","X"]
      return combo # return the win_combination indexes that won.
    elsif array_1 == ["O","O","O"]
      return combo
    end
  end
  return false
end
def full?(board)
  !(board.any? {|position| position == " " })
end
def draw?(board)
  if (won?(board) == true)
    return false
  elsif ((won?(board) == false) && (full?(board) == false))
    return false
  elsif ((won?(board) == false) && (full?(board) == true))
    return true
  end
end
def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end
def winner(board)
  if won?(board)
  character = won?(board)[0]
  board[character]
  end
end
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