require 'tk'


=begin

Layout structure:

Main Window
    Top Row Frame
        Drawable Frame
        Vertical Separator Frame
        Right Column Frame
            Controls Frame
                Buttons
                Range (Slider)
            About Frame
                Labels
    Horizontal Separator Frame
    Status Frame
        Labels

=end


# Main Window
main_window = TkRoot.new {
    title "Conway's Gem of Life" # TODO: change title later
    minsize 640, 480
    #resizable false, false # TODO: uncomment me
    padx 2
    pady 2
    background 'black'
}

### Frames ###

# Top Row Frame
top_row_frame = TkFrame.new {
    pack :fill => 'both', :expand => true
}

# Drawable Frame
drawable_frame = TkFrame.new(top_row_frame) {
    background 'yellow' # TODO: remove me
    pack :side => 'left', :fill => 'both', :expand => true
}

# Vertical Separator Frame
v_separator_frame =  TkFrame.new(top_row_frame) {
    width 2
    background 'black'
    pack :side => 'left', :fill => 'y'
}

# Right Column Frame
r_column_frame = TkFrame.new(top_row_frame) {
    width 180
    background 'purple' # TODO: remove me
    pack :side => 'left', :fill => 'y'
}

# Horizontal Separator Frame
h_separator_frame =  TkFrame.new() {
    height 2
    background 'black'
    pack :fill => 'x'
}

# Status Frame
status_frame = TkFrame.new {
    height 20
    background 'white' # TODO: remove me
    pack :fill => 'x'
}

### Elements ###


# Run
main_window.mainloop
