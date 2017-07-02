require 'tk'
require_relative 'config'

class UI

    # I don't know why this is the case...
    ORIGIN_X = 3
    ORIGIN_Y = 3

    def clear_canvas()
        @canvas.delete('all')
        TkcRectangle.new(@canvas, ORIGIN_X, ORIGIN_Y, CANVAS_WIDTH + ORIGIN_X, CANVAS_HEIGHT + ORIGIN_Y, :fill => 'gray', :width => 0)
    end

    def draw_canvas()
        clear_canvas()

        for i in 0 ... N_CELLS_PER_COL
            start_y = ORIGIN_Y + 1 + i * (CELL_HEIGHT + 1)
            end_y = start_y + CELL_HEIGHT

            for j in 0 ... N_CELLS_PER_ROW
                start_x = ORIGIN_X + 1 + j * (CELL_WIDTH + 1)
                end_x = start_x + CELL_WIDTH
                fill = ($state.board_state[i][j] == 1) ? 'black' : 'white'
                id = i * N_CELLS_PER_ROW + j
                cell = TkcRectangle.new(@canvas, start_x, start_y, end_x, end_y, :fill => fill, :width => 0, :tags => "#{id}")
                cell.bind("1", proc{ cell_clicked })
            end
        end
    end

    def cell_clicked()
        cell = @canvas.find_withtag("current")[0]
        id = cell.gettags()[0]
        $state.toggle_cell(id)
        draw_canvas()
    end

end
