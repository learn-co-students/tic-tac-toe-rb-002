def play(board)

  #input = gets.strip
  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
   puts "Cats Game!"
  else
   false
  end
end

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
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
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end



def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

def won?(board)

  draw = board.none? do |position|
    position == " "
  end

  empty = board.all? do |position|
    position == " "
  end

  WIN_COMBINATIONS.each do |combination|
    winposition1 = board[combination[0]]
    winposition2 = board[combination[1]]
    winposition3 = board[combination[2]]

    if empty
      return false
    elsif winposition1 == "X" && winposition2 == "X" && winposition3 == "X"
      return combination
    elsif winposition1 == "O" && winposition2 == "O" && winposition3 == "O"
      return combination
    else
      false
    end
  end
  if draw
    return false
  end
end

def full?(board)
  full = board.all? do |position|
    position == "X" || position == "O"
  end

  if full
    return true
  else
    return false
  end
end

def draw?(board)
  if won?(board)
    return false
  elsif full?(board)
    return true
  else
    return false
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
    return board[won?(board)[0]]
  end
end

def turn_count(board)

  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  player = turn_count(board).even? ? "X" : "O"

  return player
end
