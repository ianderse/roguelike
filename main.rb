require 'gosu'
require './map'
require './player'
require './tile'

class GameWindow < Gosu::Window
	def initialize
		super(1900, 1080, false)

		self.caption = "Ruby Roguelike"

		map_width = 61
		map_height = 34

		room_max_size = 10
		room_min_size = 6
		max_rooms = 15

		$image_tiles = Gosu::Image.load_tiles(self, './data/gfx/fantasy-tileset.png', 32, 32, false)
		$monsters = []

		@map = Map.new(map_width, map_height, self)

		@map.make_map(max_rooms, room_min_size, room_max_size, map_width, map_height)

		@player = Player.new(self, @map, @map.player_x, @map.player_y, 'player')
	end

	def update
	end

	def draw
		@map.draw
		$monsters.each do |i|
			i.draw
		end
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