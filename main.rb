require 'tk'
require_relative 'state'
require_relative 'ui'
require_relative 'canvas'

# Init singletons
$state = State.new
$ui = UI.new

# Run mainloop
$ui.run()
