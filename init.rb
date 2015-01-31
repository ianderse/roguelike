#TODO: switch use of Tiles to an actual floor/wall object?  Makes fov/collision potentially much less complicated.

require 'gosu'
require './lib/map'
require './lib/player'
require './lib/tile'
require './lib/main_scene'
require './lib/inventory'
require './lib/item'
require './lib/leaf'
require './lib/button_handler'
require './lib/messager'

window = GameWindow.new.show
