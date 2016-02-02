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
  return false if position.to_i.to_s != position.to_s
  !(position_taken?(board, position.to_i-1))
end

def turn(board)
  begin
    print "\nPlayer #{current_player(board)}, please enter position 1-9: "
    position = gets.chomp.to_i
    puts 
  end until position && position > 0 && position <10
  move(board, position, current_player(board)) if valid_move?(board, position)
  # require 'pry'c;binding.pry
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
   turn(board)
  end
  display_board(board)
  puts
  puts won?(board) ? "Congratulations #{winner(board)}!" : "Cats Game!"
  # puts "Congratulations #{winner(board)}!" if won?(board)
end

