WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  sep = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts sep
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts sep
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, num, char="X")
  board[num.to_i - 1] = char
end

def position_taken?(board, position)
  if board[position] == "" || board[position] == " " || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, position)
  position = position.to_i
  if position_taken?(board, position - 1) || !(position.between?(1, 9))
    false
  else
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  num = gets.strip
  if !valid_move?(board, num)
    turn(board)
  end
  move(board, num, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
    WIN_COMBINATIONS.any? do |arr|
      win_index_1 = arr[0]
      win_index_2 = arr[1]
      win_index_3 = arr[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if position_1 == "X" && position_2 == "X" && position_3 == "X" || 
         position_1 == "O" && position_2 == "O" && position_3 == "O"
         return arr
      else
        false
      end
    end
end


def full?(board)
  board.all? { |position| position == "X" || position == "O" } ? true : false
end

def draw?(board)
  if !(won?(board)) && full?(board)
    true
  elsif !won?(board) && !full?(board)
    false
  elsif won?(board)
    false
  end
end

def over?(board)
  (won?(board) || draw?(board) || full?(board)) ? true : false
end

def winner(board)
  if !won?(board)
    nil
  elsif won?(board)
    win = won?(board)
    char = board[win[0]]
    if char == "X"
      "X"
    elsif char == "O"
      "O"
    end
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
