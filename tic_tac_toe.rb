#Initalize player one and two
class Player

    @@player_number = 0
    @@taken_tokens = []
  
    attr_accessor :name, :token
  
    def initialize
      #Let players pick unique tokens
      @@player_number += 1
      puts "Player #{@@player_number} what character would you like to be represented by? "
      @name = "Player " + @@player_number.to_s
      @token = gets.chomp
      
      checking_tokens = true
      while checking_tokens
        if @@taken_tokens.include?(@token)
          puts "That character is already taken please chose another one: "
          @token = gets.chomp
        else
          checking_tokens = false
        end
      end
          
      @@taken_tokens.push(@token)
    end
end

class Board 
  @@cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]

  def initialize
    display_board
  end

  def display_board
    #Puts out current board
    puts "| #{@@cells[0]} | #{@@cells[1]} | #{@@cells[2]} |"
    puts "----+---+----"
    puts "| #{@@cells[3]} | #{@@cells[4]} | #{@@cells[5]} |"
    puts "----+---+----"
    puts "| #{@@cells[6]} | #{@@cells[7]} | #{@@cells[8]} |"
  end

  def play_turn(player)
      #Ask player where they want to place their token
      puts "#{player.name}, please enter a number (1-9) that is available to plan an '#{player.token}'"
      player_choice = gets.chomp.to_i
      @@cells[player_choice - 1] = player.token
      display_board
      check_win(player)     
  end

  def game(player1, player2)
    #Ask player one and two to take turns untill one wins or draw
    @@game_running = true
    while @@game_running
      play_turn(player1)
      if @@game_running
        play_turn(player2)
      end
    end

    #Ask player if they want to play again
    if @@game_running == false
      puts "Would you like to play again (Y/N): "
      play_again = gets.chomp
      if play_again.downcase == "y"
        reset_board
        game(player1, player2)
      end
    end
  end

  def check_win(player)
    #Check all the different win conditions
    if @@cells[0] == @@cells[1] && @@cells[0] == @@cells[2]
      puts "#{player.name} wins!"
      @@game_running = false
    elsif @@cells[3] == @@cells[4] && @@cells[3] == @@cells[5] 
      puts "#{player.name} wins!"
      @@game_running = false
    elsif @@cells[6] == @@cells[7] && @@cells[6] == @@cells[8] 
        puts "#{player.name} wins!"
        @@game_running = false
    elsif @@cells[0] == @@cells[3] && @@cells[0] == @@cells[6]
        puts "#{player.name} wins!"
        @@game_running = false
    elsif @@cells[1] == @@cells[4] && @@cells[1] == @@cells[7]
        puts "#{player.name} wins!"
        @@game_running = false
    elsif @@cells[2] == @@cells[5] && @@cells[2] == @@cells[8]
        puts "#{player.name} wins!"
        @@game_running = false
    elsif @@cells[0] == @@cells[4] && @@cells[0] == @@cells[8]
        puts "#{player.name} wins!"
        @@game_running = false
    elsif @@cells[2] == @@cells[4] && @@cells[2] == @@cells[6]
        puts "#{player.name} wins!"
        @@game_running = false
    end  
  end

  def reset_board
    #Create a fresh board
    @@cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    display_board
  end
end 

#Create two players
player1 = Player.new
player2 = Player.new  

#Runs game
game_board = Board.new
game_board.game(player1, player2)