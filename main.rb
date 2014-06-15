require 'gosu'
require './map'
require './player'
require './tile'

class GameWindow < Gosu::Window
	def initialize
		super(1900, 1080, false)

		self.caption = "Ruby Roguelike"

		@map_width = 61
		@map_height = 34

		@room_max_size = 10
		@room_min_size = 6
		@max_rooms = 15

		$image_tiles = Gosu::Image.load_tiles(self, './data/gfx/fantasy-tileset.png', 32, 32, false)
		$monsters = []

		reset_game

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	end

	def update
	end

	def reset_game

		$monsters.reject! do |monster|
			true
		end

		$game_state = 'playing'

		$map = Map.new(@map_width, @map_height, self)

		$map.make_map(@max_rooms, @room_min_size, @room_max_size, @map_width, @map_height)

		$player = Player.new(self, $map, $map.player_x, $map.player_y, 'player', 10, 5, 0)
	end

	def draw
		if $game_state == 'playing'
			$map.draw
			$monsters.each do |i|
				i.draw
			end
		elsif $game_state == 'dead'
			@font.draw("GAME OVER", 800, 600, 1, 2.0, 2.0, 0xffffff00)
			@font.draw("Press 'space' to continue", 800, 650, 1, 2.0, 2.0, 0xffffff00)
		end
	end

	def button_down(id)
		case id
			when Gosu::Button::KbEscape
				self.close
			when Gosu::Button::KbLeft
				$player.move_or_attack(-1,0)
			when Gosu::Button::KbRight
				$player.move_or_attack(1, 0)
			when Gosu::Button::KbUp
				$player.move_or_attack(0, -1)
			when Gosu::Button::KbDown
				$player.move_or_attack(0, 1)
			when Gosu::Button::KbSpace
				reset_game
			end
		end
end

window = GameWindow.new.show