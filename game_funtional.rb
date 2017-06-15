# gem => [x, y]

kindergarten = [[1, 1, 0, 0, 0, 0], [1, 0, 1, 0, 0, 0], [0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]


def getLiveNeighbours(kindergarten, gem)

    # Gets the possible x and y values of the neighbours
    coordinates_set = gem.map {
    
        |coordinates| [coordinates-1, coordinates, coordinates+1]
    
    }
        
    # Combine x and y coordinates to generate the neighbours
    neighbours = coordinates_set[0].map {
    
        |x| coordinates_set[1].map {
            
            |y| [x, y] unless (x == gem[0] and y == gem[1]) or (x < 0 or y < 0) # Eliminates the current gem and edge cases
            
        }.compact
    
    }.flatten(1)
    
    # Selects only the live cells
    neighbours.select {
        |live_neighbour| live_neighbour if kindergarten[live_neighbour[0]][live_neighbour[1]] == 1
    }.compact

end

def mustDie(kindergarten, gem)
    
end

def canLive(kindergarten, gem)

end

def canEmerge(kindergarten, gem)

end

def evolveKindergarten(kindergarten)

end

print getLiveNeighbours(kindergarten, [1, 1])

