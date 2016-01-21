# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

#Display TTT board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Move method
def move(board, position, value = "X")
  board[position.to_i - 1] = value
end

# Check Valid move
def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

#Position Taken method by space or nil
def position_taken?(board, position)
  !(board[position.to_i].nil? || board[position.to_i] == " ")
end

#Turn method
def turn(board)
  puts "Please enter 1-9:"
  position=gets.chomp
  if valid_move?(board, position)
    move(board, position, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Count Turn to check current player X or O
def turn_count(board)
  counter=0
  board.each do |which_player|
    if which_player == "X" || which_player == "O"
      counter += 1
    end
  end
  counter
end

#Check current player
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Won method
def won?(board)
  WIN_COMBINATIONS.detect { |combo|
    (board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
      position_taken?(board, combo[0])) }
end

# Full method
def full?(board)
  board.all? { |location| location != " "}
end

#Draw method
def draw?(board)
  board.all? { |location| location !=" " && !won?(board)}
end

#Over method
def over?(board)
  full?(board) || won?(board) || draw?(board)
end

#Winner method
def winner(board)
    if winning_combo = won?(board)
        board[winning_combo.first]
    end
end

# Play method
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