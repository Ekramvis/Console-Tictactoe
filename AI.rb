class AI_Player
  attr_accessor :loc, :symbol, :parent, :children, :win, :solutions, :grid 

  def initialize(loc, symbol, parent = nil)
    @loc = loc
    @symbol = symbol
    @parent = parent
    @children = []

    reset_symbol if @parent 

    @parent ? @grid = parent.dup_grid : @grid = Array.new(3) {[nil] * 3}

    update_board

    @win = self.check_win

    spawn unless @win || !@grid.flatten(2).include?(nil)

    @solutions = {
      :win => [],
      :lose => [],
      :draw => []
    }   

    @solutions[:win] = find_wins

    winning_moves
  end

  def reset_symbol
    self.parent.symbol == :x ? @symbol = :y : @symbol = :x
  end

  def dup_grid
    new_grid = Array.new(3) {[nil] * 3}
    @grid.each_index do |y|
      @grid[y].each_index do |x|
        new_grid[y][x] = @grid[y][x]
      end
    end
    new_grid
  end

  def update_board
    y = @loc[0]
    x = @loc[1]
    @grid[y][x] = @symbol
  end

  def check_horizontal
    win = false
    3.times do |i|
      if @grid[i].all? {|spot| spot == @grid[i][0] && spot != nil}
        @grid[i][0] == @symbol ? win = true : win = false
      end
    end
    win
  end

  def check_vertical
    win = false
    vertical_test = @grid.transpose
    3.times do |i|
      if vertical_test[i].all? {|spot| spot == vertical_test[i][0] && spot != nil}
        vertical_test[i][0] == @symbol ? win = true : win = false
      end
    end
    win
  end

  def check_diagonal
    win = false
    if @grid[0][0] == @grid[1][1] && @grid[0][0] == @grid[2][2] && @grid[0][0] != nil
      @grid[0][0] == @symbol ? win = true : win = false
    elsif @grid[0][2] == @grid[1][1] && @grid[0][2] == @grid[2][0] && @grid[0][2] != nil
      @grid[0][2] == @symbol ? win = true : win = false
    end
    win
  end

  def check_win
    check_horizontal || check_vertical || check_diagonal
  end

  def spawn
    @grid.each_index do |y|
      @grid[y].each_index do |x|
        @children << AI_Player.new([y,x], @symbol, self) if @grid[y][x].nil?
      end
    end
  end

  def find_leaves
    fringe = [self]

    until fringe.empty?
      test_case = fringe.shift
      unless test_case.children.empty?
        fringe += test_case.children
      end
    end

    nil
  end

  def find_wins
    winners = []

    self.children.each do |child|
      if child.win
        winners << child
      else
        winners += child.find_wins
      end
    end

    winners
  end

  def winning_moves
    completed_moves = []
    random_moves = []
    winning_moves = []

    self.grid.each_with_index do |row, x|
      row.each_index do |y|
        if self.grid[x][y] == self.symbol
          completed_moves << [x,y] 
        elsif self.grid[x][y] == nil
          random_moves << [x,y]
        end
      end
    end

    @solutions[:win].each do |solution|
      solution.grid.each_with_index do |row, x|
        row.each_index do |y|
          winning_moves << [x,y] if solution.grid[x][y] == solution.symbol
        end
      end
    end

    winning_moves.uniq!
    winning_moves.select! { |move| !completed_moves.include?(move) }

    next_move = winning_moves.empty? ? random_moves.sample : winning_moves.sample 

    next_move
  end

end
