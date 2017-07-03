require 'tk'
require_relative 'config'
require_relative 'canvas'
require_relative 'state'

=begin

Layout structure:

Main Window
    Top Row Frame
        Drawable Frame
            Canvas
        Vertical Separator
        Right Column Frame
            Controls Labelframe
                Buttons Row Frame
                    Start Button
                    Pause Button
                    Next Button
                    Stop Button
                    Random Button
                Delay Scale
            About Labelframe
                About Label
                Inf Logo Label
    Horizontal Separator
    Status Frame
        Status Label
        Generation Label
        Living Cells Label

=end


class UI

    CANVAS_HEIGHT = (CELL_HEIGHT + 1) * N_CELLS_PER_ROW + 1
    CANVAS_WIDTH = (CELL_WIDTH + 1) * N_CELLS_PER_COL + 1

    attr_reader :start_button, :pause_button, :next_button, :stop_button, :random_button

    def initialize()
        setup_elements()
        create_canvas()
    end

    def run()
        @main_window.mainloop
    end

    def setup_elements()
        # Main Window
        @main_window = TkRoot.new {
            title "Conway's Gem of Life" # TODO: change title later
            relief 'groove'
            borderwidth 1
            resizable false, false
        }


        ### Frames, Labelframes and Separators ###

        # Top Row Frame
        top_row_frame = TkFrame.new {
            pack :fill => 'both'
        }

        # Drawable Frame
        drawable_frame = TkFrame.new(top_row_frame) {
            pack :side => 'left', :fill => 'both', :padx => 12
        }

        # Vertical Separator
        v_separator_frame =  TkSeparator.new(top_row_frame) {
            orient 'vertical'
            pack :side => 'left', :fill => 'y'
        }

        # Right Column Frame
        r_column_frame = TkFrame.new(top_row_frame) {
            pack :side => 'right', :fill => 'y', :padx => 12, :pady => 5
        }

        # Controls Labelframe
        controls_labelframe = TkLabelframe.new(r_column_frame) {
            text ' Controls: '
            pack :pady => 5
        }

        # Buttons Row Frame
        buttons_row_frame = TkFrame.new(controls_labelframe) {
            pack :padx => 5
        }

        # About Labelframe
        about_labelframe = TkLabelframe.new(r_column_frame) {
            text ' About: '
            pack :fill => 'both', :pady => 5
        }

        # Horizontal Separator 
        h_separator_frame = TkSeparator.new() {
            pack :fill => 'x'
        }

        # Status Frame
        status_frame = TkFrame.new {
            pack :fill => 'x'
        }


        ### Elements ###

        # Canvas
        @canvas = TkCanvas.new(drawable_frame) {
            width CANVAS_WIDTH
            height CANVAS_HEIGHT
            relief 'solid'
            borderwidth 1
            background 'white'
            pack :expand => true
        }

        # Start Button
        @start_button = TkButton.new(buttons_row_frame) {
            text 'Start'
            compound 'top'
            image TkPhotoImage.new(:file => 'img/start_icon.gif')
            pack :side => 'left', :padx => 1
            command proc { $state.start }
        }

        # Pause Button
        @pause_button = TkButton.new(buttons_row_frame) {
            text 'Pause'
            state 'disabled'
            compound 'top'
            image TkPhotoImage.new(:file => 'img/pause_icon.gif')
            pack :side => 'left', :padx => 1
            command proc { $state.pause }
        }

        # Next Button
        @next_button = TkButton.new(buttons_row_frame) {
            text 'Next'
            compound 'top'
            image TkPhotoImage.new(:file => 'img/next_icon.gif')
            pack :side => 'left', :padx => 1
            command proc { $state.next }
        }

        # Stop Button
        @stop_button = TkButton.new(buttons_row_frame) {
            text 'Stop'
            state 'disabled'
            compound 'top'
            image TkPhotoImage.new(:file => 'img/stop_icon.gif')
            pack :side => 'left', :padx => 1
            command proc { $state.stop }
        }

        # Random Button
        @random_button = TkButton.new(buttons_row_frame) {
            text 'Random'
            compound 'top'
            image TkPhotoImage.new(:file => 'img/random_icon.gif')
            pack :side => 'left', :padx => 1
            command proc { $state.random }
        }

        # Delay Scale
        @delay_range = TkScale.new(controls_labelframe) {
            label 'Delay between generations (ms):'
            variable $state.ms_delay
            orient 'horizontal'
            from 100
            to 1000
            resolution 100
            pack :fill => 'x', :padx => 5
        }

        # About Label
        TkLabel.new(about_labelframe) {
            text "Grupo:\n" +
                 "Friendship is Magic\n" +
                 "\n" +
                 "Componentes:\n" +
                 "Ana Paula Mello\n" +
                 "Caio Fonseca Rodrigues\n" +
                 "Daniel Kelling Brum\n" +
                 "\n" +
                 "Disciplina:\n" +
                 "Modelos de Linguagens\n" +
                 "de Programação (2017/1)\n" +
                 "\n" +
                 "Professor:\n" +
                 "Leandro Krug Wives"
            pack :pady => 1
        }

        # Inf Logo Label
        TkLabel.new(about_labelframe) {
            image TkPhotoImage.new(:file => 'img/inf_logo.gif')
            pack :pady => 1
        }

        # Status Label
        TkLabel.new(status_frame) {
            textvariable $state.status_str
            anchor 'w'
            width 23
            pack :side => 'left'
        }

        # Generation Label
        TkLabel.new(status_frame) {
            textvariable $state.generation_str
            anchor 'w'
            width 23
            pack :side => 'left'
        }

        # Living Cells Label
        TkLabel.new(status_frame) {
            textvariable $state.living_cells_str
            anchor 'w'
            width 23
            pack :side => 'left'
        }
    end

end
