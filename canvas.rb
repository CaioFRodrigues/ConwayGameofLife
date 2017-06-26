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

        for i in 0 ... $state.board_state.size
            row = $state.board_state[i]
            start_y = ORIGIN_Y + 1 + i * (CELL_HEIGHT + 1)
            end_y = start_y + CELL_HEIGHT

            for j in 0 ... row.size
                start_x = ORIGIN_X + 1 + j * (CELL_WIDTH + 1)
                end_x = start_x + CELL_WIDTH
                fill = ($state.board_state[i][j] == 1) ? 'black' : 'white'
                TkcRectangle.new(@canvas, start_x, start_y, end_x, end_y, :fill => fill, :width => 0)
            end
        end
    end

end
