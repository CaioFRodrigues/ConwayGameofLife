require 'tk'


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
                    Stop Button
                    Next Button
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
status_str = TkVariable.new
generation_str = TkVariable.new
living_cells_str = TkVariable.new


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
canvas = TkCanvas.new(drawable_frame) {
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
}

# Pause Button
pause_button = TkButton.new(buttons_row_frame) {
    text 'Pause'
    compound 'top'
    image TkPhotoImage.new(:file => 'img/pause_icon.gif')
    pack :side => 'left', :padx => 1
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
    justify 'left'
    pack :pady => 1
}

# Inf Logo Label
TkLabel.new(about_labelframe) {
    image TkPhotoImage.new(:file => 'img/inf_logo.gif')
    pack :pady => 1
}

# Status Label
TkLabel.new(status_frame) {
    textvariable status_str
    anchor 'w'
    width 23
    pack :side => 'left'
}

# Generation Label
TkLabel.new(status_frame) {
    textvariable generation_str
    anchor 'w'
    width 23
    pack :side => 'left'
}

# Living Cells Label
TkLabel.new(status_frame) {
    textvariable living_cells_str
    anchor 'w'
    width 23
    pack :side => 'left'
}


# TODO: these will be set by the model/controller
status_str.value = 'Status: Running'
generation = 42
generation_str.value = "Generation: #{generation}"
living_cells = -2
living_cells_str.value = "Living cells: #{living_cells}"


# Run
main_window.mainloop
