require './lib/creature'

class Player < Creature
	def initialize(window, x, y, object_name, blocks=false, hp, strength, defense)
		super
	end

	def move_or_attack(x1, y1)
		@x2 = (x + x1)
		@y2 = (y + y1)
		
		if $map_obj.blocked?(@x2, @y2) && $map_obj.attackable?(@x2, @y2)
			target = $map_obj.whats_there?(@x2, @y2)
			attack(target)
		elsif $map_obj.blocked?(@x2, @y2) == false
			$map_obj.set_tile(@x, @y, 'floor')
			@x = (@x + x1)
			@y = (@y + y1)
			$map_obj.set_tile(@x, @y, 'player')

			$camera_x = [[($player.x * 31 - 5) - $window_width/2, 0].max, $window_width * 31 - 5].min
			$camera_y = [[($player.y * 31 - 5) - $window_height/2, 0].max, $window_height * 31 - 5].min
		end
		$monsters.each do |monster|
			monster.take_turn
		end
	end

	def rest
		if self.hp < self.max_hp
			self.hp += 1
		end

		$monsters.each do |monster|
			monster.take_turn
		end

		@window.message("Player is resting")
	end
end