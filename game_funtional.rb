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

isAlive = lambda { |neighbour, kindergarten| neighbour if kindergarten[neighbour[0]][neighbour[1]] == 1 }

def getLiveNeighbours(kindergarten, neighbours, isAlive)

    first, *rest = *neighbours

    if neighbours.empty?
        return []
    elsif isAlive.call(first, kindergarten)
        return [first].concat getLiveNeighboursR(kindergarten, rest, isAlive)
    else
        return getLiveNeighboursR(kindergarten, rest, isAlive)
    end
    
end

# def getLiveNeighbours(kindergarten, gem)
    
    # isAlive = lambda { |neighbour, kindergarten| neighbour if kindergarten[neighbour[0]][neighbour[1]] == 1 }

    # generateNeighbours(kindergarten, gem, getPossibleCoordinates(gem)).select {
    
        # |neighbour| isAlive.call(neighbour, kindergarten)
        
    # }.compact

# end


def evolveKindergarten(kindergarten)

    mustDie = lambda {|live_neighbours| live_neighbours.length > 3 or live_neighbours.length < 2}
    canLive = lambda {|live_neighbours| live_neighbours.length == 3}

        (0..kindergarten.length-1).map{
            |x| (0..kindergarten.length-1).map{
                |y|
                                
                if kindergarten[x][y] == 1
                    if mustDie.call(getLiveNeighbours(kindergarten, [x, y]))
                        0
                    else
                        1
                    end
                    
                else kindergarten[x][y] == 0
                    if canLive.call(getLiveNeighbours(kindergarten, [x, y]))
                        1
                    else
                        0
                    end
                end
            }
        }

end

# print evolveKindergarten(kindergarten)

print getLiveNeighbours(kindergarten, generateNeighbours(kindergarten, [1,1], getPossibleCoordinates([1,1])), isAlive)