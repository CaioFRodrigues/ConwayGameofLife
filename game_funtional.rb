# gem => [x, y]

kindergarten = [[1, 1, 0, 0, 0, 0], [1, 0, 1, 0, 0, 0], [0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]

def getPossibleCoordinates(gem)
    # Gets the possible x and y values of the neighbours

    gem.map {
    
        |coordinates| [coordinates-1, coordinates, coordinates+1]
    
    }

end


def generateNeighbours(kindergarten, gem, coordinates_set)

    isCurrentGem = lambda {|x, y, gem| gem[0] == x and gem[1] == y}
    isOutsideLimits = lambda {|x, y, kindergarten| x < 0 or y < 0 or x >= kindergarten.length or y >= kindergarten.length}

    coordinates_set[0].map {
        
            |x| coordinates_set[1].map {
                            
                |y| [x, y] unless isCurrentGem.call(x, y, gem) or isOutsideLimits.call(x, y, kindergarten)
                
        }.compact
        
    }.flatten(1)

end

def getLiveNeighbours(kindergarten, gem)

    isAlive = lambda { |neighbour, kindergarten| kindergarten[neighbour[0]][neighbour[1]] == 1}
    
    generateNeighbours(kindergarten, gem, getPossibleCoordinates(gem)).select {
    
        |neighbour| neighbour if isAlive.call(neighbour, kindergarten)
        
    }.compact

end

def mustDie(kindergarten, gem)
    return 0
end

def canLive(kindergarten, gem)
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
                        canLive(kindergarten, kindergarten[x][y])
                    else
                        kindergarten[x][y]
                    end
                end
            }
        }

end

print evolveKindergarten(kindergarten)

