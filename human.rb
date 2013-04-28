class Human < Player

  def place_mark(i,j,game)
    game.grid[i][j] = @mark
  end

  def move(game)
    puts "pick a spot (use the coordinates x (width) and y (height)!) First enter x, then hit enter and enter y."
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    place_mark(x,y,game)
  end


end