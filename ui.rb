require 'tk'


=begin

Layout structure:

Main Window
    Top Row Frame
        Drawable Frame
        Vertical Separator
        Right Column Frame
            Controls Labelframe
                Buttons Row Frame
                    Play Button
                    Pause Button
                    Stop Button
                    Next Button
                    Random Button
                Delay Scale
            About Labelframe
                Group Name Label
                Student Names Label
                Class Name Label
                Teacher Name Label
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
    minsize 640, 480
    resizable false, false
    relief 'groove'
    borderwidth 1
}


### Frames, Labelframes and Separators ###

# Top Row Frame
top_row_frame = TkFrame.new {
    pack :fill => 'both', :expand => true
}

# Drawable Frame
drawable_frame = TkFrame.new(top_row_frame) {
    pack :side => 'left', :fill => 'both', :expand => true
}

# Vertical Separator
v_separator_frame =  TkSeparator.new(top_row_frame) {
    orient 'vertical'
    pack :side => 'left', :fill => 'y'
}

# Right Column Frame
r_column_frame = TkFrame.new(top_row_frame) {
    width 200
    pack_propagate false
    pack :side => 'right', :fill => 'y'
}

# Controls Labelframe
controls_labelframe = TkLabelframe.new(r_column_frame) {
    text ' Controls: '
    height 140
    pack_propagate false
    pack :fill => 'x', :padx => 12, :pady => 6
}

# Buttons Row Frame
buttons_row_frame = TkFrame.new(controls_labelframe) {
    height 60
    pack_propagate false
    pack :fill => 'x'
}

# About Labelframe
about_labelframe = TkLabelframe.new(r_column_frame) {
    text ' About: '
    pack :fill => 'both', :padx => 12, :pady => 6
}

# Horizontal Separator 
h_separator_frame = TkSeparator.new() {
    pack :fill => 'x'
}

# Status Frame
status_frame = TkFrame.new {
    height 20
    pack_propagate false
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
    pack_propagate false
    pack :expand => true
}

# Play Button
play_button = TkButton.new(buttons_row_frame) {
    text 'Play'
    height 60
    pack_propagate false
    pack :side => 'left'
}

# Pause Button
pause_button = TkButton.new(buttons_row_frame) {
    text 'Pause'
    height 60
    pack_propagate false
    pack :side => 'left'
}

# Stop Button
stop_button = TkButton.new(buttons_row_frame) {
    text 'Stop'
    height 60
    pack_propagate false
    pack :side => 'left'
}

# Next Button
next_button = TkButton.new(buttons_row_frame) {
    text 'Next'
    height 60
    pack_propagate false
    pack :side => 'left'
}

# Random Button
random_button = TkButton.new(buttons_row_frame) {
    text 'Random'
    height 60
    pack_propagate false
    pack :side => 'left'
}

# Delay Scale
delay_range = TkScale.new(controls_labelframe) {
    label 'Delay (ms):'
    orient 'horizontal'
    from 100
    to 1000
    resolution 100
    pack :fill => 'x'
}

# Group Name Label
TkLabel.new(about_labelframe) {
    text "Grupo:\n" +
         "Friendship is Magic"
    justify 'left'
    pack :anchor => 'w', :padx => 16, :pady => 1
}

# Student Names Label
TkLabel.new(about_labelframe) {
    text "Componentes:\n" +
         "Ana Paula Mello\n" +
         "Caio Fonseca Rodrigues\n" +
         "Daniel Kelling Brum"
    justify 'left'
    pack :anchor => 'w', :padx => 16, :pady => 1
}

# Class Name Label
TkLabel.new(about_labelframe) {
    text "Disciplina:\n" +
         "Modelos de Linguagens\n" +
         "de Programação (2017/1)"
    justify 'left'
    pack :anchor => 'w', :padx => 16, :pady => 1
}

# Teacher Name Label
TkLabel.new(about_labelframe) {
    text "Professor:\n" +
         "Leandro Krug Wives"
    justify 'left'
    pack :anchor => 'w', :padx => 16, :pady => 1
}

# Inf Logo Label
TkLabel.new(about_labelframe) {
    image TkPhotoImage.new(:file => 'img/inf_logo.gif')
    pack
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
