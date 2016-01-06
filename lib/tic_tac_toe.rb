board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
board_positions = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]


def display_board_positions(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

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


 def move(board, position, player= "X")
  player = current_player(board)
   altered_position= position.to_i-1
   board[altered_position] = player
   display_board(board)
 end

def position_taken?(board, position)
  altered_position = position.to_i
  if board[altered_position]== "X" || board[altered_position] == "O"
    return true
  else
    return false
  end
end

def valid_move?(board, position)
 puts convert_position = position.to_i-1 
 if position_taken?(board, convert_position)
    return false
  else 
    if convert_position.between?(0,9)
     return true
    else
     return false 
    end
  end
end
def turn(board)
  puts "#{current_player(board)}, Please enter position you would like to move"
  input = gets.chomp
  player = current_player(board)
  while valid_move?(board, input) != true
    puts "Please enter valid move"
    input = gets.chomp
  end
    move(board,input,player)
end

def turn_count(board)
  count = 0
  board.each do |i|
    if i == "X" || i == "O"
      count +=1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2 == 0 
    return "X"
  else 
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X" ||position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end
  false
end

def full?(board)
  count =0
  board.each do |i|
    if i == "X" || i == "O"
      count += 1
    end
  end
  if count <9
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) && won?(board) == false
    true
  else  
    false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end


def winner(board)
  if over?(board) && won?(board) == false
    return nil
  elsif over?(board) && won?(board)
     x = won?(board)[1]
     return board[x]
    
  else
    return nil
  end
end

def play(board, board_positions)
  display_board_positions(board_positions)
  while over?(board) == false
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

play(board, board_positions)