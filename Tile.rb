class Tile

	@@alive_gems = 0
	def initialize(row,col,alive = false)
		@row = row
		@col = col
		@alive = alive
		if @alive
			@@alive_gems+= 1
		end
	end

	#Returns whether or not the gem is alive or not
	def is_alive
		@alive
	end

	#Returns the number of gems currently alive
	def get_alive_gems
		@@alive_gems
	end

	#Returns the collumn of the gem
	def get_col
		@col
	end

	#Returns the Row of the Gem
	def get_row
		@row
	end

	#Kills a living Being
	def shatter_gem
		@alive = false
		@@alive_gems -= 1
	end 
	#Make a new gem on the spot
	def create_life
		@alive = true
		@@alive_gems += 1
	end

	#Given a list of nearby gems, update the gem so that it will survive or die
	def evolve_gem(near_alive_gems)

		if is_alive && (near_alive_gems < 2 || near_alive_gems > 3)
 			shatter_gem

	 		elsif !is_alive && near_alive_gems == 3
 			create_life
 		end
	end
end