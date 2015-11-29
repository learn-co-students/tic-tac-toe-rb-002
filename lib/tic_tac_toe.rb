
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Diagonal
  [6,4,2], # Diagonal
]

def display_board(board)
  puts " #{board[0]} "  "|" " #{board[1]} " "|"  " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} "  "|" " #{board[4]} " "|"  " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} "  "|" " #{board[7]} " "|"  " #{board[8]} "
  puts "-----------"
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


def won?(board)

  WIN_COMBINATIONS.any? do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
      else
      false
    end
  
  end
end

def full?(board)
  spot = 0
  9.times do 
    if position_taken?(board, spot)
      spot += 1
    else 
      return false
    end
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
      return false
    else
      return true
    end
  else
    return false
  end
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)

  if won?(board) == false
    return nil
  else
    winning_array = won?(board)
    winning_character = board[winning_array[0]]
    return winning_character
  end
end

def move(board, input, character)
  input = input.to_i
  board[input - 1] = character
  return board
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  display_board(board)
  puts "Please enter 1-9:"
  input = gets.strip
  player = current_player(board)
  if valid_move?(board, input)
    move(board, input, player)
  else
    turn(board)
  end
end

def turn_count(board)
  turn_count = 9
  board.each do |position|
    if position == " "
      turn_count -= 1
    end
  end
  return turn_count
  
end

def current_player(board)

  if turn_count(board).even?
    return "X"
  else
    return "O"
  end

end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end  
