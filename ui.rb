require 'tk'
require_relative 'canvas'

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


# TODO: these will be managed by the model/controller
$status_str = TkVariable.new
$generation_str = TkVariable.new
$living_cells_str = TkVariable.new


# TODO: temp canvas size hacks, remove me
$iter = 0

# Canvas config temp hack
$valid_combinations = [
{'n_cells' => 20, 'canvas_size' => 401},
{'n_cells' => 20, 'canvas_size' => 421},
{'n_cells' => 21, 'canvas_size' => 400},
{'n_cells' => 21, 'canvas_size' => 421},
{'n_cells' => 22, 'canvas_size' => 419},
{'n_cells' => 23, 'canvas_size' => 415},
{'n_cells' => 24, 'canvas_size' => 409},
{'n_cells' => 25, 'canvas_size' => 401},
{'n_cells' => 25, 'canvas_size' => 426},
{'n_cells' => 26, 'canvas_size' => 417},
{'n_cells' => 27, 'canvas_size' => 406},
{'n_cells' => 28, 'canvas_size' => 421},
{'n_cells' => 29, 'canvas_size' => 407},
{'n_cells' => 30, 'canvas_size' => 421},
{'n_cells' => 31, 'canvas_size' => 404},
{'n_cells' => 32, 'canvas_size' => 417},
{'n_cells' => 33, 'canvas_size' => 430},
{'n_cells' => 34, 'canvas_size' => 409},
{'n_cells' => 35, 'canvas_size' => 421},
{'n_cells' => 37, 'canvas_size' => 408},
{'n_cells' => 38, 'canvas_size' => 419},
{'n_cells' => 39, 'canvas_size' => 430},
{'n_cells' => 40, 'canvas_size' => 401},
{'n_cells' => 41, 'canvas_size' => 411},
{'n_cells' => 42, 'canvas_size' => 421},
{'n_cells' => 45, 'canvas_size' => 406},
{'n_cells' => 46, 'canvas_size' => 415},
{'n_cells' => 47, 'canvas_size' => 424},
{'n_cells' => 50, 'canvas_size' => 401},
{'n_cells' => 51, 'canvas_size' => 409},
{'n_cells' => 52, 'canvas_size' => 417},
{'n_cells' => 53, 'canvas_size' => 425},
{'n_cells' => 57, 'canvas_size' => 400},
{'n_cells' => 58, 'canvas_size' => 407},
{'n_cells' => 59, 'canvas_size' => 414},
{'n_cells' => 60, 'canvas_size' => 421},
{'n_cells' => 61, 'canvas_size' => 428},
{'n_cells' => 67, 'canvas_size' => 403},
{'n_cells' => 68, 'canvas_size' => 409},
{'n_cells' => 69, 'canvas_size' => 415},
{'n_cells' => 70, 'canvas_size' => 421},
{'n_cells' => 71, 'canvas_size' => 427},
{'n_cells' => 80, 'canvas_size' => 401},
{'n_cells' => 81, 'canvas_size' => 406},
{'n_cells' => 82, 'canvas_size' => 411},
{'n_cells' => 83, 'canvas_size' => 416},
{'n_cells' => 84, 'canvas_size' => 421},
{'n_cells' => 85, 'canvas_size' => 426},
{'n_cells' => 100, 'canvas_size' => 401},
]

def draw_combination
    n_cells = $valid_combinations[$iter]['n_cells']
    canvas_size = $valid_combinations[$iter]['canvas_size']
    draw_canvas_prototype($canvas, canvas_size, n_cells)
    $status_str.value = ""
    $generation_str.value = "n_cells: #{n_cells}"
    $living_cells_str.value = "canvas_size: #{canvas_size}"
end

def prev_combination
    if $iter > 0
        $iter -= 1
    end

    draw_combination
end

def next_combination
    if $iter < $valid_combinations.size - 1
        $iter += 1
    end

    draw_combination
end

# Main Window
main_window = TkRoot.new {
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
$canvas = TkCanvas.new(drawable_frame) {
    width 400
    height 400
    relief 'solid'
    borderwidth 1
    background 'white'
    pack :expand => true
}

# Start Button
play_button = TkButton.new(buttons_row_frame) {
    text 'Start'
    compound 'top'
    image TkPhotoImage.new(:file => 'img/start_icon.gif')
    pack :side => 'left', :padx => 1
    command proc {prev_combination} 
}

# Pause Button
pause_button = TkButton.new(buttons_row_frame) {
    text 'Pause'
    compound 'top'
    image TkPhotoImage.new(:file => 'img/pause_icon.gif')
    pack :side => 'left', :padx => 1
    command proc {next_combination} 
}

# Next Button
next_button = TkButton.new(buttons_row_frame) {
    text 'Next'
    compound 'top'
    image TkPhotoImage.new(:file => 'img/next_icon.gif')
    pack :side => 'left', :padx => 1
}

# Stop Button
stop_button = TkButton.new(buttons_row_frame) {
    text 'Stop'
    compound 'top'
    image TkPhotoImage.new(:file => 'img/stop_icon.gif')
    pack :side => 'left', :padx => 1
}

# Random Button
random_button = TkButton.new(buttons_row_frame) {
    text 'Random'
    compound 'top'
    image TkPhotoImage.new(:file => 'img/random_icon.gif')
    pack :side => 'left', :padx => 1
}

# Delay Scale
delay_range = TkScale.new(controls_labelframe) {
    label 'Delay between generations (ms):'
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
    textvariable $status_str
    anchor 'w'
    width 23
    pack :side => 'left'
}

# Generation Label
TkLabel.new(status_frame) {
    textvariable $generation_str
    anchor 'w'
    width 23
    pack :side => 'left'
}

# Living Cells Label
TkLabel.new(status_frame) {
    textvariable $living_cells_str
    anchor 'w'
    width 23
    pack :side => 'left'
}


# TODO: these will be set by the model/controller
#status_str.value = 'Status: Running'
#generation = 42
#generation_str.value = "Generation: #{generation}"
#living_cells = -2
#living_cells_str.value = "Living cells: #{living_cells}"


# TODO: canvas size hack, remove
n_cells = $valid_combinations[$iter]['n_cells']
canvas_size = $valid_combinations[$iter]['canvas_size']
draw_canvas_prototype($canvas, canvas_size, n_cells)


# Run
main_window.mainloop
