WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
 ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, position, char="X")
   position = position.to_i - 1
  board[position] = char
  if (turn_count(board).even?)
    board[position] = "O"
  else
    board[position] = "X"
  end
end

def position_taken?(board, position)
  if ((board[position] == "X") || (board[position] == "O" ))
    return true
  elsif board[position] == nil
    false
  else
    false
  end
end


def valid_move?(board, position)
  num = (position.to_i)-1
  if (((0..8) === num) && (board[num] == " "))
     return true
  else
    false
  end
end


def turn(board)
    puts "Please enter 1-9:"
    position = gets.strip
  if valid_move?(board, position)
    move(board, position)
    display_board(board)
  else
    turn(board)

  end
end


def turn_count(board)
  count = 0
  board.each do |turn|
      if ((turn == "X") || (turn == "O"))
         count += 1
      end
   end
  return count
end

def current_player(board)
  if (turn_count(board).even?)
    return "X"
  else
    return "O"
  end
end


def won?(board)
  combo = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,4,8]
  ]
    count = 0
  while count <=7
      win_index_1 = combo[count][0]
      win_index_2 = combo[count][1]
      win_index_3 = combo[count][2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]
      if (((position_1 == "X") && (position_2 == "X") && (position_3 == "X") ) ||((position_1 == "O") &&
        (position_2 == "O") && (position_3 == "O")))
          return combo[count]
      elsif
        false
      end
    count += 1
  end
end

def full?(board)
  if board.all? {|piece| (piece == "X" )||(piece == "O")}
    return true
 else
    false
 end
end

def draw?(board)
  if full?(board) && !(won?(board))
    return true
  else false
  end
end

def over?(board)
  if (full?(board) || won?(board) || draw?(board))
    return true
  else false
  end
end

def winner(board)
  if won?(board)
       arry = won?(board)
         modarry = (board[arry[0]..arry[2]]).select {|x| x == "X"}
         modarry2 = (board[arry[0]..arry[2]]).select {|x| x == "O"}
      if modarry == ["X","X","X"]
        return "X"
      end

      if  modarry2 == ["O","O","O"]
        return "O"
      end
  else
      return nil
  end

end

def play(board)

until over?(board)
    turn(board)
  end
   if won?(board)
     if winner(board) == "X"
       puts "Congratulations X!"
     else
       puts "Congratulations O!"
     end
   elsif draw?(board)
     puts "Cats Game!"
   end
end

