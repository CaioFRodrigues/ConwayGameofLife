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
            
            |y| [x, y] unless (x == gem[0] and y == gem[1]) or (x < 0 or y < 0) or (x >= kindergarten.length or y >= kindergarten.length) # Eliminates the current gem and edge cases
            
        }.compact
    
    }.flatten(1)
    
    # Selects only the live cells
    neighbours.select {
        |live_neighbour| live_neighbour if kindergarten[live_neighbour[0]][live_neighbour[1]] == 1
    }.compact

end

def mustDie(kindergarten, gem)
    return 0
end

def canLive(kindergarten, gem)
    return 1
end

def canEmerge(kindergarten, gem)
    return 1
end

def evolveKindergarten(kindergarten)

        (0..kindergarten.length-1).map{
            |x| (0..kindergarten.length-1).map{
                |y|
                
                if kindergarten[x][y] == 1
                    if getLiveNeighbours(kindergarten, [x, y]).length > 3 or getLiveNeighbours(kindergarten, [x, y]).length < 2
                        mustDie(kindergarten, kindergarten[x][y])
                    else
                        canLive(kindergarten, kindergarten[x][y])
                    end
                else kindergarten[x][y] == 0
                    if getLiveNeighbours(kindergarten, [x, y]).length == 3
                        canEmerge(kindergarten, kindergarten[x][y])
                    else
                        kindergarten[x][y]
                    end
                end
            }
        }

end

print evolveKindergarten(kindergarten)

