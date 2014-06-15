class GameWindow < Gosu::Window
	def initialize
		$window_width = 1280
		$window_height = 1020
		super($window_width, $window_height, false)

		self.caption = "Ruby Roguelike"

		@map_width = 100
		@map_height = 100

		@room_max_size = 10
		@room_min_size = 6
		@max_rooms = 15

		@msg_width = 500
		@msg_height = 220
		$game_msgs = []

		$msg_black = Gosu::Color.new(100, 0, 0, 0)
		$msg_white = Gosu::Color.new(100, 255, 255, 255)
		$white = Gosu::Color.new(255, 255, 255, 255)
		$black = Gosu::Color.new(255, 0, 0, 0)
		$red = Gosu::Color.new(255, 160, 0, 0)

		$image_tiles = Gosu::Image.load_tiles(self, './data/gfx/fantasy-tileset.png', 32, 32, false)
		$monsters = []

		reset_game

		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	end

	def update
	end

	def message(text, color = $msg_white)
		$game_msgs.each do |msg|
			if $game_msgs.length > (@msg_height / 22).to_i
				$game_msgs.delete(msg)
			end
		end
		$game_msgs << text
	end

	def draw_messages
		self.draw_quad(0, 800, $msg_black, @msg_width, 800, $msg_black, 0, 800 + @msg_height, $msg_black, @msg_width, 800 + @msg_height, $msg_black, 2)
		y = 800
		$game_msgs.each do |msg|
			@font.draw(msg, 5, y, 3, 1.0, 1.0, $msg_white)
			y += 20
		end
	end

	def draw_bar(x, y, w, h, color1, color2, z=2, object)
		self.draw_quad(x, y, $white, x + w, y, $white, x, y + h, $white, x + w, y + h, $white, z)    
		self.draw_quad(x + 1, y + 1, $black, x + w - 1, y + 1, $black, x + 1, y + h - 1, $black, x + w - 1, y + h - 1, $black, z)
		
		hp = object.hp
		max_hp = object.max_hp

		length = (((hp*w)/100) * 100) / max_hp

		self.draw_quad(x + 1, y + 1, color2, x + length - 1, y + 1, color2, x + 1, y + h - 1, color2, x + length - 1, y + h - 1, color2, z)
	end

	def reset_game

		$monsters.reject! do |monster|
			true
		end

		$game_state = 'playing'

		$map = Map.new(@map_width, @map_height, self)

		$map.make_map(@max_rooms, @room_min_size, @room_max_size, @map_width, @map_height)

		$player = Player.new(self, $map, $map.player_x, $map.player_y, 'player', 20, 5, 0)

		$camera_x = [[($player.x * 31 - 5) - $window_width/2, 0].max, $window_width * 31 - 5].min
		$camera_y = [[($player.y * 31 - 5) - $window_height/2, 0].max, $window_height * 31 - 5].min
	end

	def draw
		if $game_state == 'playing'
			translate(-$camera_x, -$camera_y) do
				$map.draw
				$monsters.each do |i|
					i.draw
				end
			end
			draw_bar($window_width/2 - 50, $window_height - 20, 200, 20, $white, $red, 2, $player)
			@font.draw("HP: ", $window_width/2 - 100, $window_height, 1, 1.25, 1.25, $red)
			draw_messages
		elsif $game_state == 'dead'
			@font.draw("GAME OVER", $window_width/2 - 100, $window_height/2, 1, 2.0, 2.0, 0xffffff00)
			@font.draw("Press 'space' to continue", $window_width/2 - 100, $window_height/2 + 30, 1, 2.0, 2.0, 0xffffff00)
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
			when Gosu::Button::Kb5
				$player.rest
			when Gosu::Button::KbSpace
				if $game_state == 'dead'
					reset_game
				end
			end
		end
end