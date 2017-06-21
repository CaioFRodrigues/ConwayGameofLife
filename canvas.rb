require 'tk'

CANVAS_SIZE = 430
N_CELLS = 39
CELL_SIZE = 10

# I don't know why this is the case...
ORIGIN_X = 3
ORIGIN_Y = 3

def clear_canvas(canvas)
    canvas.delete('all')
    TkcRectangle.new(canvas, ORIGIN_X, ORIGIN_Y, CANVAS_SIZE + ORIGIN_X, CANVAS_SIZE + ORIGIN_Y, :fill => 'gray', :width => 0)
end

def draw_canvas(canvas, cells)
    for i in 0 ... cells.size
        row = cells[i]
        start_y = ORIGIN_Y + 1 + i * (CELL_SIZE + 1)
        end_y = start_y + CELL_SIZE

        for j in 0 ... row.size
            start_x = ORIGIN_X + 1 + j * (CELL_SIZE + 1)
            end_x = start_x + CELL_SIZE
            fill = (cells[i][j] == 1) ? 'black' : 'white'
            TkcRectangle.new(canvas, start_x, start_y, end_x, end_y, :fill => fill, :width => 0)
        end
    end
end

def redraw_canvas(canvas)
    clear_canvas(canvas)
    draw_canvas(canvas, cells)
end
