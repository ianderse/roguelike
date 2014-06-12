require 'gosu'
require './map'
require './player'
require './tile'


class GameWindow < Gosu::Window
	def initialize
		super(800, 600, false)

		self.caption = "Map Generator"

		@map = Map.new(300, 300, self)

		@room1 = Rect.new(@window, 5, 5, 10, 15)
		@room2 = Rect.new(@window, 20, 5, 10, 15)

		@map.create_room(@room1)
		@map.create_room(@room2)

		@player = Player.new(self, @map, 6, 6)

		#@map.set_tile(6, 6, 'player')

		
	end

	def update
	end

	def draw
		@map.draw
		#@player.draw
	end

	def button_down(id)
		case id
			when Gosu::Button::KbEscape
				self.close
			when Gosu::Button::KbLeft
				@player.move(-1,0)
			when Gosu::Button::KbRight
				@player.move(1, 0)
			when Gosu::Button::KbUp
				@player.move(0, -1)
			when Gosu::Button::KbDown
				@player.move(0, 1)
			end
		end
end

window = GameWindow.new.show