class GameWindow < Gosu::Window
	def initialize
		$window_width = 1280
		$window_height = 1020
		super($window_width, $window_height, false)

		self.caption = "Ruby Roguelike"

		$map_width = 100
		$map_height = 100

		@room_max_size = 10
		@room_min_size = 6
		@max_rooms = 15

		@msg_width = 500
		@msg_height = 220

		$first_room = true
		$player_x = $player_y = 0

		$msg_black = Gosu::Color.new(100, 0, 0, 0)
		$msg_white = Gosu::Color.new(100, 255, 255, 255)
		$white = Gosu::Color.new(255, 255, 255, 255)
		$black = Gosu::Color.new(255, 0, 0, 0)
		$red = Gosu::Color.new(255, 160, 0, 0)

		$image_tiles = Gosu::Image.load_tiles(self, './data/gfx/fantasy-tileset.png', 32, 32, false)
		$monsters = []
		$items = []
		$bag = []
		$leafs = []
		$game_msgs = []

		@inventory = Inventory.new(self)

		reset_game

		$font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	end

	def needs_cursor?; true; end

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
			$font.draw(msg, 5, y, 3, 1.0, 1.0, $msg_white)
			y += 20
		end
	end

	def draw_hp_bar(x, y, w, h, color1, color2, z=2, object)
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

		$items.reject! do |item|
			true
		end

		$game_state = 'playing'

		$map_obj = Map.new($map_width, $map_height, self)
		$map = $map_obj.init_map
		leaf = Leaf.new(0,0, $map_width, $map_height)

		#$map_obj.player_x = $map_obj.player_y = 0

		leaf.create_leafs
		$map_obj.set_tile($player_x, $player_y, 'player')

		#$map_obj.make_map(@max_rooms, @room_min_size, @room_max_size, $map_width, @map_height)

		$player = Player.new(self, $player_x, $player_y, 'player', 20, 5, 500)

		$camera_x = [[($player.x * 31 - 5) - $window_width/2, 0].max, $window_width * 31 - 5].min
		$camera_y = [[($player.y * 31 - 5) - $window_height/2, 0].max, $window_height * 31 - 5].min
	end

	def draw
		if $game_state == 'playing'
			translate(-$camera_x, -$camera_y) do
				$map_obj.draw
				$monsters.each do |i|
					i.draw
				end
				$items.each do |i|
					i.draw
				end
			end
			draw_hp_bar($window_width/2 - 50, $window_height - 20, 200, 20, $white, $red, 2, $player)
			$font.draw("HP: ", $window_width/2 - 100, $window_height - 25, 2, 1.25, 1.25, $red)
			draw_messages
		elsif $game_state == 'inventory'
			@inventory.draw
		elsif $game_state == 'dead'
			$font.draw("GAME OVER", $window_width/2 - 150, $window_height/2, 1, 2.0, 2.0, 0xffffff00)
			$font.draw("Press 'space' to continue", $window_width/2 - 150, $window_height/2 + 30, 1, 2.0, 2.0, 0xffffff00)
		end
	end

	def button_down(id)
		if $game_state == 'playing'
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
				when Gosu::Button::KbI
					$game_state = @inventory.toggle
				when Gosu::Button::KbG
					$items.each do |i|
						if i.x == $player.x && i.y == $player.y
							i.pick_up
						end
					end
				when Gosu::MsLeft #need to figure out how to convert map x to mouse_x
					# $monsters.each do |monster|
					# 	if Gosu::distance(monster.x * 12.8, -monster.y * 10.2, mouse_x, mouse_y) < 10
					# 		puts monster.x * 12.8
					# 		puts mouse_x
					# 		message(monster.name)
					# 	end
					# end
			end
		elsif $game_state == 'dead'
			if id == Gosu::Button::KbSpace
				reset_game
			elsif id == Gosu::Button::KbEscape
				self.close
			end
		elsif $game_state == 'inventory'
			@inventory.button_handle(id)
		end
	end
end