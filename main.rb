require 'gosu'
require './map'
require './player'
require './tile'


class GameWindow < Gosu::Window
	def initialize
		super(1900, 1080, false)

		self.caption = "Ruby Roguelike"

		map_width = 62
		map_height = 40

		room_max_size = 10
		room_min_size = 6
		max_rooms = 10

		@map = Map.new(map_width, map_height, self)

		@map.make_map(max_rooms, room_min_size, room_max_size, map_width, map_height)

		@player = Player.new(self, @map, @map.player_x, @map.player_y)


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
			when Gosu::Button::KbLeft
				@player.move(-1,0)
			when Gosu::Button::KbRight
				@player.move(1, 0)
			when Gosu::Button::KbUp
				@player.move(0, -1)
			when Gosu::Button::KbDown
				@player.move(0, 1)
			when Gosu::Button::KbSpace
				@player.clear
			end
		end
end

window = GameWindow.new.show