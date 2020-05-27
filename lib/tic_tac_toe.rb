class TicTacToe
#Defining a class. We will be playing the game via instances of TicTacToe.
#When we define TicTacToe.new, we will be bringing a new game to life!
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

#@board = instance variable that expreses the state of the game. Who won, who lost, position.
def initialize
  @board = Array.new(9, " ")
end

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

#accepts users input as an argument, converts that to an integer in array format (0-8)
def input_to_index(user_input)
  user_input.to_i - 1
end
#index = position. (spot on the board (0-8))
def move(index, current_player = "X")
  @board[index] = current_player
end

def position_taken?(index) #index = position i
  !(@board[index].nil? || @board[index] == " ")
end #returns true or false based on whether the position on board is occupied.

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end #returns true or false if the position is already taken and checks that the move is on the game board.

def turn_count #counts occupied positions!
  turn = 0 #start at position 0.
  @board.each do |index| #iterating through each spot on the board. Is it occupied?
    if index == "X" || index == "O" #if there is an X or O in that spot,
      turn += 1 #then you must turn!
    end
  end
  return turn  #if there is not an X or O in that spot, take your turn and put your X or O there.
end

def current_player
  #if the turn count is an even number, that means O just went, so the next/current player is X
  #returns the correct player, X or O, for the next move, even or odd.
  num_turns = turn_count
  if num_turns % 2 == 0
    player = "X"
  else
    player = "O"
  end
  return player
end

def turn
  puts "Please choose a number 1-9:"
  user_input = gets.chomp #recieves the users input.
  index = input_to_index(user_input) #calls the previous methods to play the next turn.
  if valid_move?(index) #makes sure the turn is a valid move.
    player_token = current_player
    move(index, player_token)
    display_board
  else
    turn
  end
end

def won?
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = @board[index_0]
    position_2 = @board[index_1]
    position_3 = @board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?
  @board.all? {|index| index == "X" || index == "O"}
end

def draw?
  if !won? && full?
    return true
  else
    return false
  end
end

def over?
  if won? || draw?
    return true
  else
    return false
  end
end

def winner
  index = []
  index = won?
  if index == false
    return nil
  else
    if @board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play
  until over? == true
    turn
  end

  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
end

end
