load 'player.rb'
load 'human.rb'
load 'computer.rb'
load 'board.rb'
load 'MainUI.rb'
load 'treenode.rb'

class Game

  def self.play
    Game.new
  end

  def initialize
    game_type = set_params
    return exit if game_type == 'Q'
    set_players(game_type)
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
      @player1 = Human.new("X")
      @player2 = Computer.new("O")
    when '3'
      @player1 = Computer.new("X")
      @player2 = Computer.new("O")
    end
  end

  def set_board
    @board = Board.set_up
  end

  def game_loop
    @current_player = @player2
    @enemy_player = @player1

    until @board.win?
      @current_player, @enemy_player = @enemy_player, @current_player
      @board.display
      move = @current_player.move
      @board.update(move)
    end

    puts "[Say (current_player) wins here]"
    replay 
  end

  def replay
    MainUI.replay? ? self.play : exit
  end

  def exit
    MainUI.exit
  end


end #end Game class