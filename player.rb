require './creature'

class Player < Creature
	def initialize(window, map, x, y, object_name, blocks=false, hp, strength, defense)
		super
	end

	def move_or_attack(x1, y1)
		@x2 = (x + x1)
		@y2 = (y + y1)
		
		if @map.blocked?(@x2, @y2) && @map.attackable?(@x2, @y2)
			target = @map.whats_there?(@x2, @y2)
			attack(target)
		elsif @map.blocked?(@x2, @y2) == false
			@map.set_tile(@x, @y, 'floor')
			@x = (@x + x1)
			@y = (@y + y1)
			@map.set_tile(@x, @y, 'player')

			$camera_x = [[($player.x * 31 - 5) - $window_width/2, 0].max, $window_width * 31 - 5].min
			$camera_y = [[($player.y * 31 - 5) - $window_height/2, 0].max, $window_height * 31 - 5].min
			puts $camera_x, $camera_y
		end
		$monsters.each do |monster|
			monster.take_turn
		end
	end
end