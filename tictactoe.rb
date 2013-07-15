load 'player.rb'
load 'human.rb'
load 'computer.rb'
load 'board.rb'
load 'MainUI.rb'
load 'AI.rb'
# load 'test_code.rb'

class Game

  def self.play
    Game.new
  end

  def initialize
    game_type = set_params
    return exit if game_type == 'Q'
    menu = set_players(game_type)
    if menu == "quit"
      return exit 
    end

    set_board
    game_loop
  end

  def set_params
    MainUI.choose_game
  end

  def set_players(game_type)
    case game_type
    when '1' 
      @player1 = Human.new("X")
      @player2 = Human.new("O")
    when '2'
      @player1 = Computer.new("X")
      @player2 = Human.new("O")
    when '3'
      "quit"
    end
  end

  def set_board
    @board = Board.new
  end

  def game_loop
    @current_player = @player2
    @enemy_player = @player1

    until @board.check_win
      @current_player, @enemy_player = @enemy_player, @current_player
      @board.display
      move = @current_player.move(@board)
    end

    puts ""
    @board.display

    if @board.grid.flatten.none? { |spot| spot == nil }
      puts ""
      puts "********"
      puts "DRAW!!!!"
      puts "********"
      puts ""
    else
      puts ""
      puts "********"
      puts @current_player.mark + " WINS!!!" 
      puts "********"
      puts ""
    end

    replay 
  end

  def replay
    MainUI.replay? ? Game.play : exit
  end

  def exit
    MainUI.exit
  end


end #end Game class


Game.new