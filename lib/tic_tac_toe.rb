def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #top left to bottom right
  [6,4,2]  #bottom left to top right
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def won?(board)
  array = false

  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == "X" && 
       board[combo[1]] == "X" && 
       board[combo[2]] == "X" || 
       board[combo[0]] == "O" && 
       board[combo[1]] == "O" && 
       board[combo[2]] == "O"
      array = [combo[0],combo[1],combo[2]]
    end
  end

  return array
end

def full?(board)
  board.each do |token|
    if token == " "
      return false
    end
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  elsif !won?(board) && !full?(board)
    return false
  else
    return false
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  boardwon = won?(board)
  if boardwon == false
    return nil
  else 
    board[boardwon[0]]
  end
end

def move(board, position, token = current_player(board))
    board[position.to_i - 1] = token
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
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
  counter = 0
  board.each do |num|
    if num == "X" || num == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  (turn_count(board).even? ? "X" : "O")
end

def play(board)
  until over?(board)
    turn(board)
    current_player(board)
  end
  if winner(board) == nil
    puts "Cats Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end