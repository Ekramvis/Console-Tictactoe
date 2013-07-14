class Human < Player

  def move(game)
    puts "pick a spot (use the coordinates x (width) and y (height)!) First enter x, then hit enter and enter y."
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    game.place_mark(x,y, self.mark)
  end


end