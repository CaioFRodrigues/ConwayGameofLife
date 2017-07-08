class Tile

	@@alive_gems = 0
	def initialize(row, col, alive = false)
		@row = row
		@col = col
		@alive = alive
		if @alive
			@@alive_gems+= 1
		end
	end

    attr_reader :alive, :alive_gems, :row, :col

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

		if @alive && (near_alive_gems < 2 || near_alive_gems > 3)
 			shatter_gem

 		elsif !@alive && near_alive_gems == 3
 			create_life
 		end

	end
end