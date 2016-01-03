# Helper Methods
def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5], #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6], #first column
  [1, 4, 7], #second column
  [2, 5, 8], #third column
  [0, 4, 8], #first diagonal
  [6, 4, 2] #second diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    position_1 = board[combination[0]]
    position_2 = board[combination[1]]
    position_3 = board[combination[2]]

    return combination if (position_1 == "X") && (position_1 == position_2) && (position_2 == position_3)
    return combination if (position_1 == "O") && (position_1 == position_2) && (position_2 == position_3)
  end
  false
end

#returns string of who won the game
def who_won?(board)
  return false if !won?(board)
  winning_line = won?(board)
  return board[winning_line[0]]
end

def full?(board)
  board.all? {|square| (square == "X") || (square == "O")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  return nil if (!over?(board) || draw?(board))
  who_won?(board)
end

def valid_move?(board, position = "")
  position = position.to_i
  if position.between?(1, 9)
    !position_taken?(board, position - 1) 
  else
    return false
  end
end
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your move method here!
def move(board, position, char="X")
  position = position.to_i
  if board[position-1] == " "
    board[position-1] = char
  end  
end

def turn(board)
  input = gets.strip
  until valid_move?(board, input)
    puts "Invalid move"
    input = gets.strip
  end
  move(board, input, current_player(board))
  display_board(board)
end
 
def current_player(board)
  (turn_count(board) % 2 == 0) ? "X" : "O"
end

def turn_count(board)
  board.count {|square| !square.strip.empty? }
end

def play(board)
  while !over?(board) 
    puts "#{current_player(board)}, what move do you want to make?"
    display_board(board)
    turn(board)
  end
  if !winner(board)
    puts "Cats Game!"
  else 
    puts "Congratulations #{winner(board)}!"
  end
end    
