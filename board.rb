class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(3) {[nil] * 3}
  end

  def display
    tl = @grid[0][0] || "_"
    tm = @grid[0][1] || "_"
    tr = @grid[0][2] || "_"

    ml = @grid[1][0] || "_"
    mm = @grid[1][1] || "_"
    mr = @grid[1][2] || "_"

    bl = @grid[2][0] || " "
    bm = @grid[2][1] || " "
    br = @grid[2][2] || " "

    frame = [
      [""],
      [""],
      ["  ", "1", " 2", " 3"].join,
      ["A", " ", "#{tl}", "|", "#{tm}", "|", "#{tr}"].join,
      ["B", " ", "#{ml}", "|", "#{mm}", "|", "#{mr}"].join,
      ["C", " ", "#{bl}", "|", "#{bm}", "|", "#{br}"].join,
      [" "],
      [" "]
    ]

    frame.each { |line| puts line }
    nil
  end

  def dup
    new_board = Board.new
    @grid.each_index do |y|
      @grid[y].each do |x|
        new_board.grid[y][x] = @grid[y][x]
      end
    end
    new_board
  end

  def place_mark(x,y,mark)
    self.grid[x][y] = mark
  end

  def validate_move(x,y)
    self.grid[x][y].nil?
  end

  def check_horizontal
    win = false
    3.times do |i|
      if @grid[i].all? {|spot| spot == @grid[i][0] && spot != nil}
        win = true
      end
    end
    win
  end

  def check_vertical
    win = false
    vertical_test = @grid.transpose
    3.times do |i|
      if vertical_test[i].all? {|spot| spot == vertical_test[i][0] && spot != nil}
        win = true
      end
    end
    win
  end

  def check_diagonal
    win = false
    if @grid[0][0] == @grid[1][1] && @grid[0][0] == @grid[2][2] && @grid[0][0] != nil
      win = true
    elsif @grid[0][2] == @grid[1][1] && @grid[0][2] == @grid[2][0] && @grid[0][2] != nil
      win = true
    end
    win
  end

  def check_win
    check_horizontal || check_vertical || check_diagonal || self.grid.flatten.none? { |spot| spot == nil }
  end
end
