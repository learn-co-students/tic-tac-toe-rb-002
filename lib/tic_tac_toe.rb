WIN_COMBINATIONS = [ 
  [0,1,2], [3,4,5], [6,7,8],
  [0,4,8], [6,4,2], [0,3,6],
  [1,4,7], [2,5,8]
]

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} " 
    puts "-----------" 
    puts " #{board[3]} | #{board[4]} | #{board[5]} "   
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} " 
  end


  def move(board, position, letter = "X")
    board[position.to_i-1] = letter
  end


  def position_taken?(board, position)
    if board[position] == " " 
      false
    else
      true
    end
  end

  def valid_move?(board, position)
    if position_taken?(board, position.to_i - 1) == false && position.to_i.between?(1,9)
      true
    elsif position_taken?(board, position.to_i - 1)
      false
    end
  end

  def turn(board)
    display_board(board)
    puts "Please enter 1-9:"
    input = gets

    while true
      if valid_move?(board, input)
        move(board, input.to_i, current_player(board))
        break
      else
        puts "Invalid - please try again"
        display_board(board)
        puts "Please enter 1-9:"
        input = gets
      end
    end
  end

  def turn_count(board)
    board.select { |el| el.match(/[XO]/) }.count
  end

  def current_player(board)
    turn_count(board) == 0 || turn_count(board).even? ? "X" : "O"
  end

  def won?(board)
    WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" ||
        board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O" 
        return combo 
      end
  end
  false
  end

  def full?(board)
    return true if board.all? { |el| el.match(/[XO]/) } 
    false
  end

  def draw?(board)
    return true if full?(board) && won?(board) == false
    false
  end

  def over?(board)
    return true if draw?(board) || won?(board) || full?(board)
    false
  end

  def winner(board)
    if won?(board)
      board[won?(board)[0]]
    end
  end

  def play(board)
       until over?(board) 
         turn(board)
       end

         if won?(board)
          display_board(board)
           puts "Congratulations #{winner(board)}!"
         else
          display_board(board)
           puts "Cats Game!"
         end
  end