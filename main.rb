require 'gosu'
require './map'

class GameWindow < Gosu::Window
	def initialize
		super(800, 600, false)

		self.caption = "Map Generator"

		@map = Map.new(50, 50, self)
		@map.set_wall_tile(0,0, true)
	end

	def update
	end

	def draw
		@map.draw
	end

	def button_down(id)
		case id
			when Gosu::Button::KbEscape
				self.close
			end
		end
end

window = GameWindow.new.show