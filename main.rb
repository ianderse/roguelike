require 'gosu'
require './map'
require './player'

class GameWindow < Gosu::Window
	def initialize
		super(1600, 1200, false)

		self.caption = "Map Generator"

		@player = Player.new(self)

		@map = Map.new(100, 100, self)

		room1 = Rect.new(@window, 5, 5, 10, 15)
		room2 = Rect.new(@window, 20, 5, 10, 15)

		@map.create_room(room1)
		@map.create_room(room2)

		
	end

	def update
	end

	def draw
		@map.draw
		@player.draw
	end

	def button_down(id)
		case id
			when Gosu::Button::KbEscape
				self.close
			when Gosu::Button::KbLeft
				@player.x -= 50
			when Gosu::Button::KbRight
				@player.x += 50
			when Gosu::Button::KbUp
				@player.y -= 50
			when Gosu::Button::KbDown
				@player.y += 50
			end
		end
end

window = GameWindow.new.show