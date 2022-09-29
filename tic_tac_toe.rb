#tic tac toe game
class Game 
  @@turn_count = 1
  @@winner = ''
  @@board_hash = { 1 => [0, 0], 2 => [0, 1], 3 => [0, 2], 4 => [1, 0], 5 => [1, 1], 6 => [1, 2], 7 => [2, 0], 8 => [2, 1], 9 => [2, 2]}

  def initialize
    puts 'Player 1 - enter your name'
    @player_one_name = gets.chomp
    puts 'Player 2 - enter your name'
    @player_two_name = gets.chomp 
    @board = Array.new(3) { Array.new(3)}
    @board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  #build the graphical representation of 2D array grid in ruby CLI
  def display_board(board)
    puts "\r"
    puts " #{board[0][0]} | #{board[0][1]} | #{board[0][2]} "
    puts "---+---+---"
    puts" #{board[1][0]} | #{board[1][1]} | #{board[1][2]} "
    puts "---+---+---"
    puts" #{board[2][0]} | #{board[2][1]} | #{board[2][2]} "
    puts "\r"
  end

  
  def player_turn(turn)
    if turn.odd?
        player_choice(@player_one_name, 'X')
    else
        player_choice(@player_two_name, 'O')
    end
  end
 


#Player user input prompt

  def player_choice(player, symbol)
    puts "#{player} please enter your grid choice"
    #input = gets.chomp.to_i
    #coordinate = @@board_hash[input]  
    input = gets.chomp.to_i
    coordinate = @@board_hash[input]
    coordinate_one = coordinate[0]
    coordinate_two = coordinate[1]
    coordinate_conversion = @board[coordinate[0]][coordinate[1]]
    # loop until user input is valid
    until (coordinate_conversion < 10) && (coordinate_conversion > 0) && @board[coordinate[0]][coordinate[1]] != 'X' && @board[coordinate[0]][coordinate[1]] != 'O'
      puts "Please enter valid coordinates for an empty space in the grid"
      input = gets.chomp.to_i
      coordinate = @@board_hash[input]
      coordinate_one = coordinate[0]
      coordinate_two = coordinate[1]
    end

    add_to_board(coordinate_one, coordinate_two, symbol)
  end

  def add_to_board(coordinate_one, coordinate_two, symbol)
    @board[coordinate_one][coordinate_two] = symbol
    @@turn_count += 1
  end


#instructions
puts "Welcome to Tic Tac Toe.  You must choose your spot by selecting coordinates for each play."
puts "Each turn, enter two numbers with a space, per the grid layout below:"
puts "\r\n"
puts " 1 | 2 | 3 "
puts "---+---+---"
puts " 4 | 5 | 6 "
puts "---+---+---"
puts " 7 | 8 | 9 "
puts "\r\n"



#Develop a way for user to choose their grid position
#Develop game logic to identify a winner

def three_across
  @board.each do |i|
    if i.all? { |j| j == 'X' }
      @@winner = 'X'
      @@turn_count = 10
    elsif i.all? { |j| j == 'O' }
      @@winner = 'O'
      @@turn_count = 10
    else
      nil
    end
  end
end

def three_down
  flat = @board.flatten
  flat.each_with_index do |v, i|
    if v == 'X' && flat[i + 3] == 'X' && flat[i + 6] == 'X'
      @@winner = 'X'
      @@turn_count = 10
    elsif v == 'O' && flat[i + 3] == 'O' && flat[i + 6] == 'O'
      @@winner = 'O'
      @@turn_count = 10
    else
      nil
    end
  end
end

def three_diagonal
  center_val = @board[1][1]
  if center_val == 'X' || center_val == 'O'
    if @board[0][0] == center_val && @board[2][2] == center_val
      @@winner = center_val
      @@turn_count = 10
    elsif @board[2][0] == center_val && @board[0][2] == center_val
      @@winner = center_val
      @@turn_count = 10
    else
      nil
    end
  end
end

def declare_result(symbol)
  case symbol
  when 'X'
    puts "#{@player_one_name} wins the game!"
  when 'O'
    puts "#{@player_two_name} wins the game!"
  else
    puts "Stale mate!!"
  end
end  

def play_game
  puts "\r\n"
  puts "Here is your gameboard -- let's begin!"
  display_board(@board)

  until @@turn_count >= 10 do
    player_turn(@@turn_count)
    three_across
    three_down
    three_diagonal
    display_board(@board)
    #for debugging -- show the 2D array as the game progresses
    #p @board
  end

  declare_result(@@winner)
end

#instantiate Game and execute play game
game = Game.new
game.play_game

end
