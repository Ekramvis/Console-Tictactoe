class MainUI

	def self.choose_game
		puts "Welcome to TicTacToe!"
	  puts 
	  puts "Please enter your selection:"
	  puts "  '1' Human vs. Human"
	  puts "  '2' Human vs. Computer"
	  puts "  '3' Quit"
	  puts 

	  gets.chomp
	end
	

	def self.exit
		puts
	  puts "*******************"
	  puts "THANKS FOR PLAYING!"
	  puts "*******************"
	  "Goodbye!"
	end

	def self.replay?
		puts
		puts "Would you like to play again?"
		puts "  'Y' for yes"
	  puts "  'N' for no"
	  puts 

	  case gets.chomp.upcase
	  when "Y" then true
	  when "N" then false
	  end
	end

end