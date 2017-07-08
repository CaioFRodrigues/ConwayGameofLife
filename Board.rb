require_relative 'Tile'

class Kindergarten		

	#initialize: initializes a board given a list with all the tiles
	def initialize(max_row, max_col, board=false)
        if board == false            
        #Initializes random board
        @tile = Array.new(max_row){Array.new(max_col)}
            for row in 0...max_row
                for col in 0...max_col
                    if [true, false].sample
                        @tile[row][col] = Tile.new row, col, true
                    else 
                        @tile[row][col] = Tile.new row, col
                    end
                end
            end      
        #Initializes from pre-made board
        else
            @tile = Array.new(board.length){Array.new(board[0].length)}
            board.each_with_index do |line, row|
                line.each_with_index do |current_gem, col|
                	if board[row][col] == 1
                    	@tile[row][col] = Tile.new  row, col, true
                    elsif board[row][col] == 0
                    	@tile[row][col] = Tile.new  row, col, false 
                   	end
                end
            end
        end
        
	end 


	def get_gems
		@tile
	end

	#Delivers the board state, getting an array of arrays with the following format
	# Board = [
	#           [0,0,1,1]
	# 			[0,1,0,1]
	#         ]
	def get_board_state
		board = Array.new(@tile.size) { Array.new(@tile[0].size)}
		@tile.each_with_index do |line, row|
			line.each_with_index do |current_gem, col|
				if current_gem.is_alive
					board[row][col] = 1
				else
					board[row][col] = 0
				end
			end
		end
		board
	end

	#Given a tile, returns the number of alive gems near it 
	def get_number_of_neighbors(tile)
		number_of_neighbors = 0
		row = tile.get_row
		col = tile.get_col
		
		#Get the boundaries for the current board
		last_row = @tile.size - 1
		last_col = @tile[0].size - 1

		#Starts getting the previous and next rows
		previous_row = row - 1
		next_row = row + 1
		previous_col = col - 1
		next_col = col + 1

		#Checks if the rows and cols are out of bounds
		if previous_row < 0
			previous_row = 0
		end
		if next_row > last_row
			next_row = last_row
		end
		if previous_col < 0
			previous_col = 0
		end
		if next_col > last_col
			next_col = last_col
		end
		#Ends getting previous and next rows
		
		#Loop to see how many neighbours there are
		for i in previous_row..next_row
			for j in previous_col..next_col
				if @tile[i][j].is_alive && (i != row || j != col) #check if there is a gem and if it is not the current one
					number_of_neighbors += 1
				end
			end
		end

		number_of_neighbors
	end

	def evolve
		#Creates copy of current generation
		next_gen = Marshal.load( Marshal.dump(@tile) )
		#Goes through each Gem, evolving them based on the current board
		next_gen.each_with_index do |line, row|
			line.each_with_index do |current_gem, col|
				number_of_neighbors = get_number_of_neighbors @tile[row][col]
				current_gem.evolve_gem number_of_neighbors
			end
		end

		@tile = Marshal.load( Marshal.dump (next_gen))		
	end

	def get_alive_gems
		@tile[0][0].get_alive_gems
	end

end

#Example of the use	
if __FILE__ == $0
    tiles = [[1,1,0,1], [0,1,0,1]]
	board = Kindergarten.new(4,4, tiles)
	print board.get_board_state
	board.evolve

	puts "NOW"
	puts board.get_board_state
end