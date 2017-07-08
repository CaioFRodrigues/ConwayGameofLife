require_relative 'game_functional'

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
        @worker_thread = Thread.new {
            loop {
                if @run_state != STATE_RUNNING
                    Thread.stop
                else
                    evolve()
                    sleep(ms_delay / 1000)
                end
            }
        }
    end

    def get_cell(id)
        i = id / N_CELLS_PER_ROW
        j = id % N_CELLS_PER_ROW
        return @board_state[i][j]
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

        @worker_thread.run

        # TODO: disable canvas interaction

        $ui.start_button[:state] = 'disabled'
        $ui.pause_button[:state] = 'normal'
        $ui.next_button[:state] = 'disabled'
        $ui.stop_button[:state] = 'normal'
        $ui.random_button[:state] = 'disabled'
    end

    def pause()
        @run_state = STATE_PAUSED
        @status_str.value = "Status: Paused"

        $ui.start_button[:state] = 'normal'
        $ui.pause_button[:state] = 'disabled'
    end

    def stop()
        @run_state = STATE_STOPPED
        @status_str.value = "Status: Stopped"

        $ui.start_button[:state] = 'normal'
        $ui.pause_button[:state] = 'disabled'
        $ui.next_button[:state] = 'normal'
        $ui.stop_button[:state] = 'disabled'
        $ui.random_button[:state] = 'normal'

        # TODO: enable canvas interaction

        @board_state = Array.new(N_CELLS_PER_COL){ Array.new(N_CELLS_PER_ROW) { 0 } } # zeroed-out board
        set_living_cells(0)
        set_generation(0)

        $ui.update_canvas()
    end

    def next()

        # TODO: disable canvas interaction

        evolve()
    end

    def evolve()
        # TODO: replace with an actual function and all...
        @board_state = evolveKindergarten(@board_state)
        set_living_cells(@living_cells + 1) # TODO: count them
        set_generation(@generation + 1)
        $ui.update_canvas()
    end

    def random()
        @board_state = Array.new(N_CELLS_PER_COL){ Array.new(N_CELLS_PER_ROW) { rand(2) } } # random board

        set_living_cells(42) # TODO: count them
        set_generation(0)

        $ui.update_canvas()
    end

end
