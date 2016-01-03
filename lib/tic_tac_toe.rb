WIN_COMBINATIONS=[
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

def play(board)
	won?(board)
	while !over?(board)
		turn(board)
		won?(board)
	end
	if won?(board)
		puts "Congratulations #{winner(board)}!"
	elsif draw?(board)
		puts "Cats Game!"
	end
end

def move(board, position, player='X')
	board[(position.to_i) -1] = player 
end

def position_taken?(board, position)
	!(board[position].nil? || board[position] == ' ')
end

def valid_move?(board, position)
		position.to_i.between?(1,9) && !position_taken?(board, (position.to_i)-1)
end

def turn_count(board)
	board.reject{|x| x == ' '}.size
end

def current_player(board)
	turn_count(board).even? ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = ''
  input = gets.chomp 
  if valid_move?(board, input)
  	move(board, input, current_player(board))
  else
  	turn(board)
  end
  display_board(board)
end


def won?(board)
	WIN_COMBINATIONS.each do |winning|
		a,b,c = winning[0], winning[1], winning[2]
		if board[a] == 'X' && board[b] == 'X' && board[c] == 'X'
			return winning
		elsif board[a] == 'O' && board[b] == 'O' && board[c] == 'O'
			return winning
		end
	end
	nil
end

def full?(board)
	!board.detect {|x| x == ' '}
end


def draw?(board) 
	full?(board) && won?(board).nil?
end 

def over?(board)
	draw?(board) || !won?(board).nil?
end

def winner(board)
	winner = won?(board)
	unless winner.nil?
		board[winner[0]]
	end
end


