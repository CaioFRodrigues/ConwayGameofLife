require 'tk'

def draw_canvas_prototype(canvas, canvas_size, n_cells)
    canvas_width = canvas_size
    canvas_height = canvas_size
    canvas.configure(:width => canvas_width, :height => canvas_height)

    cell_size = (canvas_size - n_cells - 1) / n_cells

    # clear everything
    canvas.delete('all')

    # vertical lines
    for i in 0..n_cells
        cur_x = i*(1 + cell_size) + 3 # origin is 3,3, for some reason
        TkcLine.new(canvas, cur_x, 3, cur_x, canvas_height + 3, :fill => 'gray')
    end

    # horizontal lines
    for i in 0..n_cells
        cur_y = i*(1 + cell_size) + 3 # origin is 3,3, for some reason
        TkcLine.new(canvas, 3, cur_y, canvas_width + 3, cur_y, :fill => 'gray')
    end
end

