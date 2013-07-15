class Computer < Player
  def move(game)

    new_grid = Array.new(3) { [nil] * 3 }

    game.grid.each_index do |y|
      game.grid[y].each_index do |x|
        if game.grid[y][x] == "X"
          new_grid[y][x] = :x
        elsif game.grid[y][x] == "O"
          new_grid[y][x] = :y
        else
          new_grid[y][x] = nil
        end
      end
    end

    gap = two_in_a_row(game)

    if game.grid.flatten.all? { |spot| spot == nil }
      next_move = random_move
    elsif gap 
      next_move = gap
    else
      next_move = AI_Player.new(nil,:x,nil,new_grid).winning_moves
    end

    game.place_mark(next_move[0],next_move[1], self.mark)
  end

  def random_move
    x = rand(3)
    y = rand(3)
    [x,y]
  end


  def two_in_a_row(game)
    h = check_horizontal_two(game)
    v = check_vertical_two(game)
    d = check_diagonal_two(game)

    if !h.empty?
      gap = h
    elsif !v.empty?
      gap = v
    elsif !d.empty?
      gap = d
    else 
      gap = nil
    end

    gap
  end

  def check_horizontal_two(game)
    gap = []
    3.times do |i|
      x_counter = 0
      y_counter = 0
      loc = []
      game.grid[i].each_with_index do |spot, y| 
        x_counter += 1 if spot == "X"
        y_counter += 1 if spot == "O"
        loc = [i,y] if spot == nil  
      end
      gap = loc if (x_counter == 2 || y_counter == 2)
    end
    gap 
  end

  def check_vertical_two(game)
    gap = []
    vertical_test = game.grid.transpose
    3.times do |i|
      x_counter = 0
      y_counter = 0
      loc = []
      vertical_test[i].each_with_index do |spot, y| 
        x_counter += 1 if spot == "X"
        y_counter += 1 if spot == "O"
        loc = [y,i] if spot == nil 
      end
      gap = loc if (x_counter == 2 || y_counter == 2) 
    end
    gap 
  end

  def check_diagonal_two(game)
    gap = []
    if game.grid[0][0] == game.grid[1][1] && game.grid[2][2].nil? && !game.grid[1][1].nil?
      gap = [2,2]
    elsif game.grid[0][0] == game.grid[2][2] && game.grid[1][1].nil? && !game.grid[2][2].nil?
      gap = [1,1]
    elsif game.grid[1][1] == game.grid[2][2] && game.grid[0][0].nil? && !game.grid[2][2].nil?
      gap = [0,0]
    elsif game.grid[0][2] == game.grid[1][1] && game.grid[2][0].nil? && !game.grid[1][1].nil?
      gap = [2,0]
    elsif game.grid[2][0] == game.grid[1][1] && game.grid[0][2].nil? && !game.grid[1][1].nil?
      gap = [0,2]
    elsif game.grid[2][0] == game.grid[0][2] && game.grid[1][1].nil? && !game.grid[0][2].nil?
      gap = [1,1]
    end
    gap
  end




end