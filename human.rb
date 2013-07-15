class Human < Player

  def move(game)
    puts "Pick a spot (E.g. A2)"
    move = gets.chomp.split("")

    move.map! { |v| converter(v) }
    x = move[0]
    y = move[1]

    until input_valid(move) && game.validate_move(x,y)
      puts "Not a good spot. Pick another spot (E.g. A2)"
      move = gets.chomp.split("")
      move.map! { |v| converter(v) }
      x = move[0]
      y = move[1]
    end
    
    game.place_mark(x,y, self.mark)
  end

  def converter(v)
    case v.downcase
    when "a" then 0
    when "b" then 1
    when "c" then 2
    when "1" then 0
    when "2" then 1
    when "3" then 2
    else 10
    end
  end

  def input_valid(input)
    input[0].between?(0,2)  && input[1].between?(0,2)
  end

end