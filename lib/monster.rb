require './lib/creature'

class Monster < Creature
	def initialize(window, x, y, object_name, blocks=false, hp, strength, defense)
		super
		@x = x
		@y = y
		@window = window
		@confused_num_turns = 5

		if object_name == 'bat'
			@image = $image_tiles[162]
		elsif object_name == 'orc'
			@image = $image_tiles[179]
		elsif object_name == 'gecko'
			@image = $image_tiles[154]
		elsif object_name == 'spider'
			@image = $image_tiles[155]
		else
			#@image = $image_tiles[12]
		end
	end

	def take_turn
		if ai == 'normal'
			if distance_to($player) >= 2
				move_towards($player.x, $player.y)
			elsif $player.hp > 0
				attack($player)
			end
		elsif ai == 'confused'
			random_x = rand(-1..1)
			random_y = rand(-1..1)
			self.move(random_x, random_y)
			@confused_num_turns -= 1
				if @confused_num_turns <= 0
					ai = 'normal'
				end
		end

	end

	def draw
		if visible == true
			@image.draw(@x * 31 - 5, @y * 31 - 5, 2, 1, 1)
		end
		if self.hp < self.max_hp
			@window.draw_hp_bar(@x * 31 - 10, @y * 31 - 15, 40, 5, $white, $red, 1, self)
		end
	end
end