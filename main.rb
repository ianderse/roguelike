require 'gosu'
require './map'

class GameWindow < Gosu::Window
	def initialize
		super(1600, 1200, false)

		self.caption = "Map Generator"

		@map = Map.new(100, 100, self)

		room1 = Rect.new(@window, 10, 10, 10, 15)
		#room2 = Rect.new(@window, 50, 15, 10, 15)

		@map.create_room(room1)
		#@map.create_room(room2)

		
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