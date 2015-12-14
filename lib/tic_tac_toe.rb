
WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8],
  [0,3,6],[1,4,7],[2,5,8],
  [0,4,8],[6,4,2]
  ]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, char)
  board[position - 1] = char
  board
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == ""
    return false
  elsif board[position] == nil
    return false
  elsif board[position] == "X"  || board[position] == "O"
    return true
  end
end


def valid_move?(board, position)
  if position.to_i.between?(1,9) == false
    return false
  else
    position = position.to_i - 1
  end

  if board == []
    return true
  end

  if position_taken?(board, position)
    return false
    #ooooh if the position is take, it's NOT a valid move lol
  else
    return true
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp.to_i #was something else til we put it in the loop
  if valid_move?(board,input)
    move(board,input,current_player(board))
    display_board(board)
  else
    while !valid_move?(board, input)
      puts "Please enter 1-9:"
      input = gets.chomp.to_i
      if valid_move?(board, input)
        move(board, input,current_player(board))
        display_board(board)
        break
      end
    end
  end
end

def turn_count(board)
  board.select {|position| position == "X" || position == "O"}.size
end

def current_player(board)
  #lol originally had something else that was more complicated to do this
  #but i think they're trying to help you out by having you write the methods in this order
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end


def won?(board)
  if board.all?{|x| x == " "}
    return false
  end

  status = WIN_COMBINATIONS.select do |combo|
    #this condition seems pretty janky lol
    (position_taken?(board,combo[0]) && position_taken?(board,combo[1]) && position_taken?(board,combo[2])) && (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]])
  end

  if !status.empty?
    return status[0]
  end

end


def full?(board)
  board.none? {|position| position == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
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