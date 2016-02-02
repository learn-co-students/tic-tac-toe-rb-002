WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char)
  board[position.to_i-1] = char
end

def position_taken?(board, position)
  board[position.to_i].strip != ""
end

def valid_move?(board, position)
  return false if position.to_i.to_s != position
  !(position_taken?(board, position.to_i-1))
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, "X")
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.select{|b| b.strip!=""}.size
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X":"O"
end

def won?(board)
  WIN_COMBINATIONS.each do |wc|
    x_winner = wc.select{|wc| board[wc].strip == "X"}
    o_winner = wc.select{|wc| board[wc].strip == "O"}
    return x_winner if x_winner == wc 
    return o_winner if o_winner == wc
  end
  false
end

def full?(board)
  board.select{|b| b.strip !=""}.size == 9
end

def draw?(board)
  full?(board) && won?(board)==false
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  return board[won?(board)[0]] if won?(board)
end

def play(board)
 while !(over?(board))
   display_board(board)
   puts
   puts "Player #{current_player(board)}: Please enter the position:"
    position = gets.chomp.to_i 
    move(board, position, current_player(board)) if position > 0 and position <10
  end
  puts won?(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"
  # puts "Congratulations #{winner(board)}!" if won?(board)
end

