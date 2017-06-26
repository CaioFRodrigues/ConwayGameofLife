class State

    STATE = [STATE_RUNNING = 0, STATE_STOPPED = 1]

    attr_reader :status_str, :generation_str, :living_cells_str
    attr_accessor :board_state, :run_state, :ms_delay

    def initialize()
        @board_state = Array.new(N_CELLS_PER_COL){ Array.new(N_CELLS_PER_ROW) { 0 } } # zeroed-out board
        @run_state = STATE_STOPPED
        @ms_delay = 100
        @status_str = TkVariable.new
        @generation_str = TkVariable.new
        @living_cells_str = TkVariable.new
    end

    # needs a status to string / updater
    # needs a generation to string / updater
    # needs a living cells count / updater

end
