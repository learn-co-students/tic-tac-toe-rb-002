##code is okay ## array for what a win is
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left column   
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # left-to-right diagonal
  [6,4,2]  # right-to-left diagonal
]

##code is okay ## prints the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

## code is *untested* but new ## updates board with 'move' of either X or O in desitred location ## just switched X & O
def move(board, location, current_player = "X")
  if turn_count(board) == 0 || nil
    board[location.to_i-1] = "X"
  elsif turn_count(board)%2 == 0
    board[location.to_i-1] = current_player(board)
  else
     board[location.to_i-1] = current_player(board)
   end
end

## code is okay ## determines if space is available
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

## code is okay ## determines if input area is 1) on board + 2) space is available 
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

## code is *untested* but new ## gets input each turn and if valid, requests a move
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

 ##if !valid_move?(board, input)
##    turn(board)

def play(board)
  while over?(board) == false
    turn(board)
  end
  if !won?(board)
     puts "Cats Game!"
   elsif won?(board) && winner(board) == "X"
    puts "Congratulations X!"
  else
    puts "Congratulations O!"
end
end

def turn_count(board)
  counter = 0
  board.each do |play|
  if play == "X" || play == "O"
    counter += 1
    end
  end
  counter
end


def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combo_array|
    if win_combo_array.all?{|position| position_taken?(board, position) && board[position] == "X"}
      return win_combo_array
    elsif win_combo_array.all?{|position| position_taken?(board, position) && board[position] == "O"}
      return win_combo_array
    else false
    end
  end
  false
end

def full?(board)
  board.all?{|position| position == "X" || position == "O" }
end

def draw?(board)
  !full?(board) == false
  full?(board) && won?(board) == false
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if over?(board) && !draw?(board)
    board[won?(board)[1]]
  end
end