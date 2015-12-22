def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2], #Top
  [3,4,5], #Middle
  [6,7,8], #Bottom
  [0,3,6], #Left
  [1,4,7], #Middle
  [2,5,8], #Right
  [0,4,8], #Diagonal Right
  [6,4,2]  #Diagonal Left
  ]

def move(board, location, player = "X")
  board[location.to_i-1] = player
end


def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i - 1)
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
  count = 0
  board.each do |slot|
    if slot == "X" || slot == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
     "X"
  else
     "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all?{|player| player=="X" || player=="O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    board[winning_combo.first]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
   puts "Cats Game!"
 end
end