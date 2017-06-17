require 'tk'


=begin

Yeah, this is a block comment in Ruby. I know, I agree...

Anyway, here's the layout structure:

Main Window
    Main Frame
        Drawable Frame
        Right Column Frame
            Controls Frame
                Buttons
                Range (Slider)
            About Frame
                Label
    Status Frame

=end


# Main Window
main_window = TkRoot.new {
    title "Conway's Gem of Life" # TODO: change title later
    width 640
    height 480
    padx 2
    pady 2
    resizable false, false
    pack_propagate(false)
    background 'black'
}

# Main Frame
main_frame = TkFrame.new {
    height 454
    background 'black'
    pack('side' => 'top', 'fill' => 'x')
}

# Drawable Frame
drawable_frame = TkFrame.new(main_frame) {
    width 458
    height 454
    background 'yellow' # TODO: remove me
    pack('side' => 'left')
}

# Right Column Frame
r_column_frame = TkFrame.new(main_frame) {
    width 176
    height 454
    background 'purple' # TODO: remove me
    pack('side' => 'right')
}

# Status Frame
status_frame = TkFrame.new {
    height 20
    background 'white' # TODO: remove me
    pack('side' => 'bottom', 'fill' => 'x')
}

# Canvas


# Run
main_window.mainloop