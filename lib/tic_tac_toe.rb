WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  ]


def display_board( board )
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move( board, position, char = "X" )
  board[ position -1 ] = char
end


def position_taken?( board, position )
  board[ position ] != " "
end


def valid_move?( board, position )
  p = position.to_i

  if p.between?(1, 9) && !position_taken?( board, p - 1 )
    true
  end
end


def turn( board )
#Asking the user for their move by position 1-9.
  puts "Please input 1-9:"
# Receiving the user input.
  position = gets.chomp
# If the move is valid, make the move.
# If the move is invalid, ask for a new move until a valid move is received.
  until valid_move?( board, position) do
    puts "Please input 1-9:"
    position = gets
  end
  p = position.to_i
  move( board, p, current_player(board) )
# Display the board after the valid move has been made.
  display_board( board)
end


def turn_count( board )
  count = 0
  board.each do |e|
    if e != " "
      count += 1
    end
  end
  count
end


def current_player( board )
  turn_count(board).even? ? "X" : "O"
end


def won?( board )
  WIN_COMBINATIONS.each do |c|
    if board[c[0]] == board[c[1]] && board[c[1]] == board[c[2]] && ( board[c[0]] == "X" || board[c[0]] == "O")
      return c
    end
  end
  false
end


def full?( board )
  !board.include?(" ")
end


def draw?( board )
  full?( board ) && !won?( board )
end


def over?( board )
  won?( board ) || draw?( board ) || full?( board )
end


def winner( board )
  win = won?(board)
  win ? board[ win[0] ] : nil
end


def play( board )
  until over?( board ) do
    turn( board )
  end

  if won?( board )
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end