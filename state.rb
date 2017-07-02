class State

    STATE = [STATE_RUNNING = 0, STATE_PAUSED = 1, STATE_STOPPED = 2]

    attr_accessor :ms_delay
    attr_reader :board_state, :run_state, :generation, :living_cells,
                :status_str, :generation_str, :living_cells_str

    def initialize()
        @board_state = Array.new(N_CELLS_PER_COL){ Array.new(N_CELLS_PER_ROW) { 0 } } # zeroed-out board
        @ms_delay = TkVariable.new
        @run_state = STATE_STOPPED
        @living_cells = 0
        @generation = 0
        @status_str = TkVariable.new("Status: Stopped")
        @generation_str = TkVariable.new("Generation: 0")
        @living_cells_str = TkVariable.new("Living cells: 0")
    end

    def toggle_cell(id)
        i = id / N_CELLS_PER_ROW
        j = id % N_CELLS_PER_ROW
        @board_state[i][j] = (@board_state[i][j] + 1) % 2
    end

    def set_living_cells(living_cells)
        @living_cells = living_cells
        @living_cells_str.value = "Living cells: #{living_cells}"
    end

    def set_generation(generation)
        @generation = generation
        @generation_str.value = "Generation: #{generation}"
    end

    def start()
        @run_state = STATE_RUNNING
        @status_str.value = "Status: Running"

        # create/wake background worker?
        # disable canvas interaction
    end

    def pause()
        @run_state = STATE_PAUSED
        @status_str.value = "Status: Paused"

        # sleep background worker?
        # disable random button
    end

    def stop()
        @run_state = STATE_STOPPED
        @status_str.value = "Status: Stopped"

        # kill background worker?
        # enable random button
        # enable next button
        # enable canvas interaction

        @board_state = Array.new(N_CELLS_PER_COL){ Array.new(N_CELLS_PER_ROW) { 0 } } # zeroed-out board
        set_living_cells(0)
        set_generation(0)

        $ui.draw_canvas()
    end

    def next()
        # TODO: replace with an actual function and all...
        @board_state[5][5] = 1 # TODO: change me to an evolve function
        set_living_cells(@living_cells + 1) # TODO: count them
        set_generation(@generation + 1)

        # disable canvas interaction

        $ui.draw_canvas()
    end

    def random()
        @board_state = Array.new(N_CELLS_PER_COL){ Array.new(N_CELLS_PER_ROW) { rand(2) } } # random board

        set_living_cells(42) # TODO: count them
        set_generation(0)

        $ui.draw_canvas()
    end

end
