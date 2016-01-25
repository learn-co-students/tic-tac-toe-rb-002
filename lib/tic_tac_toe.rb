#require 'pry'

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[6,4,2],[0,3,6],[1,4,7],[2,5,8]]

# Define Helper Methods, here...
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player = "X")
  board[location.to_i-1] = player
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

def turn_count(board)
  i = 0
  board.each do |player|
    if player == "X" || player == "O"
      i += 1
    end
  end
  return i
end

def current_player(board)
  #if turn_count(board) % 2 == 0
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
  return "X"
end

def won?(board)
  WIN_COMBINATIONS.each do |wc|
    i1 = wc[0]
    i2 = wc[1]
    i3 = wc[2]
    p1 = board[i1]
    p2 = board[i2]
    p3 = board[i3]
    if position_taken?(board,i1) && position_taken?(board,i2) && position_taken?(board,i3)
      if p1 == p2 && p1 == p3 && p2 == p3
        return wc
      end
    end
  end
  return nil
end

#full? method
def full?(board)
  !board.any?{|i| i == " " || i == nil} && !won?(board)
end

#draw? method
def draw?(board)
  full?(board) && !won?(board)
end

#over? method
def over?(board)
  full?(board) || won?(board) || draw?(board)
end

#winner method
def winner(board)
  ret = won?(board)
  if ret
    return board[ret[0]]
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end #until

  if won?(board)
     puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end

end

