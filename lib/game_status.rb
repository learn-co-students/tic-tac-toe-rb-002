# Helper Method
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
  [2, 4, 6] #second diagonal
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


