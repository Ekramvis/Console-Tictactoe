require "debugger"

class TreeNode 

	attr_accessor :parent, :children, :win, :symbol, :player_id, :grid

	def initialize(loc, player_id, parent = nil)
		@loc = loc
		@parent = parent
		@children = []

		@player_id = player_id

		@parent ? @symbol = set_symbol : @symbol = @player_id
		@parent ? @grid = parent.dup_grid : @grid = Array.new(3) {[nil] * 3}

		update_self
		
		@win = self.check_win

		spawn unless @win || !@grid.flatten(2).include?(nil)
			
		@solutions = {
			:win => [],
			:lose => [],
			:draw => []
		}		

	end

	def set_symbol
		parent.symbol == 'x' ? @symbol = 'y' : @symbol = 'x'
	end

	def update_self
		y = @loc[0]
		x = @loc[1]
		@grid[y][x] = @symbol
	end

	def spawn
		@grid.each_index do |y|
			@grid[y].each_index do |x|
				@children << TreeNode.new([y,x], @player_id, self) if @grid[y][x].nil?
			end
		end
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
	

	def find_leaves(target = true)
		#debugger
		fringe = [self]

		until fringe.empty?
			

			test_case = fringe.shift

			@solutions[:win] << test_case if test_case.check_win == target
	
			unless test_case.children.empty?
				fringe += test_case.children
			end

		end

		nil
	end


	def check_horizontal
		win = false
		3.times do |i|
			if @grid[i].all? {|spot| spot == @grid[i][0] && spot != nil}
				@grid[i][0] == player_id ? win = true : win = false
			end
		end
		win
	end

	def check_vertical
		win = false
		vertical_test = @grid.transpose
		3.times do |i|
			if vertical_test[i].all? {|spot| spot == vertical_test[i][0] && spot != nil}
				vertical_test[i][0] == player_id ? win = true : win = false
			end
		end
		win
	end

	def check_diagonal
		win = false
		if @grid[0][0] == @grid[1][1] && @grid[0][0] == @grid[2][2] && @grid[0][0] != nil
			@grid[0][0] == player_id ? win = true : win = false
		elsif @grid[0][2] == @grid[1][1] && @grid[0][2] == @grid[2][0] && @grid[0][2] != nil
			@grid[0][2] == player_id ? win = true : win = false
		end
		win
	end

	def check_win
		check_horizontal || check_vertical || check_diagonal
	end

end #end TreeNode class
