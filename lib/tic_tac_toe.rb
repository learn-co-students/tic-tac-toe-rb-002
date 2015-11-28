# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],[3, 4, 5],[6, 7, 8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]
]

# Define display_board that accepts a board and prints out the current state.

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} \n-------------\n #{board[3]} | #{board[4]} | #{board[5]} \n-------------\n #{board[6]} | #{board[7]} | #{board[8]} \n"
end


# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end


# code your #valid_move? method here
def valid_move?(board, position)
  position = position.to_i
  
  if !(position_taken?(board, position-1)) && position.between?(1,9)
    return true
  else
    return false
  end
end

def move(board, position, token = "X")
  position = position.to_i
  board[position -1] = token
  return board
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


# Define your play method below

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

def turn_count(board)
  number_of_turns_played = 0
  board.each do |num|
    if (num == "X") || (num == "O")
      number_of_turns_played += 1
    end
  end
  return number_of_turns_played
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
    board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?(board, win_combination[0])    
  end
end


def full?(board)
  board.none?{|i| i ==" "} || false
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if winner = won?(board)
    board[winner[0]]
  end
end


