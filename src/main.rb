require 'tk'
require_relative 'config'
require_relative 'ctrl/state'
require_relative 'ui/ui'
require_relative 'ui/canvas'

# Init singletons
$state = State.new
$ui = UI.new

# Setup chosen controller for the evolve function
if ARGV.length > 0
    case ARGV[0]
    when "f", "F", "functional", "Functional", "FUNCTIONAL"
        $state.evolve_method = State::FUNCTIONAL
    when "o", "O", "oo", "OO", "oop", "OOP", "object", "Object"
        $state.evolve_method = State::OOP
    else
        puts "Usage: " + __FILE__ + " [Functional|OOP]"
        exit
    end
end

# Run mainloop
$ui.run()
