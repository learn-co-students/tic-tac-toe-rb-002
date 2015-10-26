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

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def positions_taken?(board, *positions)
  positions.all? do |position|
    position_taken?(board, position)
  end
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  board.select do |cell|
    cell == "X" || cell == "O"
  end.length
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def same_chars?(board, p1, p2, p3)
  board[p1] == board[p2] && board[p1] == board[p3]
end

def won?(board)
  WIN_COMBINATIONS.find do |c|
    c1, c2, c3 = c[0], c[1], c[2]
    positions_taken?(board, c1, c2, c3) && same_chars?(board, c1, c2, c3)
  end
end

def full?(board)
  positions_taken?(board, 0, 1, 2, 3, 4, 5, 6, 7, 8)
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if winning_combination = won?(board)
    board[winning_combination.first]
  end
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
