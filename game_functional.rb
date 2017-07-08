
# For tests only
kindergarten = [[1, 1, 0, 0, 0, 0], [1, 0, 1, 0, 0, 0], [0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]

LIVE_CELL = 1
DEAD_CELL = 0

def getPossibleCoordinates(gem_coordinates)
    # Gets the possible x and y values for the gem's neighbours
    
    # gem_coordinates => [x,y]
    
    gem_coordinates.map {
    
        |coordinates| [coordinates-1, coordinates, coordinates+1]
    
    }

end


def generateNeighbours(kindergarten, gem_coordinates, coordinates_set)

    # kindergarten => matrix representing the gems status
    # gem_coordinates => [x,y]
    # coordinates_set => list of possible x and y values for the gem's neighbours
    #                    in the format [[x0,x1,x2],[y0,y1,y2]]

    # Edge cases
    isCurrentGem = lambda {|x, y, gem_coordinates| gem_coordinates[0] == x and gem_coordinates[1] == y}
    isOutsideLimits = lambda {|x, y, kindergarten| x < 0 or y < 0 or x >= kindergarten.length or y >= kindergarten.length}

    coordinates_set[0].map {
        
            |x| coordinates_set[1].map {
                            
                |y| [x, y] unless isCurrentGem.call(x, y, gem_coordinates) or isOutsideLimits.call(x, y, kindergarten)
                
        }.compact
        
    }.flatten(1)    # Removes one list layer from the resulting, "formatting" it into [[x0,y0], [x1,y1], ... ,[x7, y7]]

end


def getLiveNeighbours(kindergarten, neighbours, isAlive)
    
    # kindergarten => matrix representing the gems' status
    # neighbours => list of coordinates in format [[x0,y0], [x1,y1], ... ,[x7, y7]]
    # isAlive => test function that recieves a gem and a kindergarten

    head, *tail = *neighbours

    if neighbours.empty?
        return []
    elsif isAlive.call(head, kindergarten)
        return [head] + getLiveNeighbours(kindergarten, tail, isAlive)
    else
        return getLiveNeighbours(kindergarten, tail, isAlive)
    end
    
end


def evolveKindergarten(kindergarten)
    game_rules = getGameRules()
    applyGameRules(kindergarten, game_rules)
end


def applyGameRules(kindergarten, game_rules)

    (0..kindergarten.length-1).map{
        |x| (0..kindergarten.length-1).map{
            |y|
            
            gem_coordinates = [x,y]
            neighbours = generateNeighbours(kindergarten, gem_coordinates, getPossibleCoordinates(gem_coordinates))
                            
            if game_rules[:isAlive].call(gem_coordinates, kindergarten)
                if game_rules[:mustDie].call(getLiveNeighbours(kindergarten, neighbours, game_rules[:isAlive]))
                    DEAD_CELL
                else
                    LIVE_CELL
                end
                
            else
                if game_rules[:canLive].call(getLiveNeighbours(kindergarten, neighbours, game_rules[:isAlive]))
                    LIVE_CELL
                else
                    DEAD_CELL
                end
            end
        }
    }

end


def getGameRules()
    return {

        isAlive: lambda {|gem_coordinates, kindergarten| gem_coordinates if kindergarten[gem_coordinates[0]][gem_coordinates[1]] == LIVE_CELL },
        canLive: lambda {|live_neighbours| live_neighbours.length == 3},
        mustDie: lambda {|live_neighbours| live_neighbours.length > 3 or live_neighbours.length < 2}

    }
end
