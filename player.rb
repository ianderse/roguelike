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
			#will need to change how set_tile works, somehow adjust it to reading what object is being passed into it (self)
			#add check to see if player walks off screen
		end
		$monsters.each do |monster|
			monster.take_turn
		end
	end
end