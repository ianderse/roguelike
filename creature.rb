require './gameobject.rb'
include Math

class Creature < GameObject
	attr_accessor :hp, :strength, :defense

	def initialize(window, map, x, y, object_name, blocks=false, hp, strength, defense)
		super(window, map, x, y, object_name, blocks=false)
	end

	def distance_to(other)
		dx = other.x - x
		dy = other.y - y

		Math.sqrt(dx ** 2 + dy ** 2)
	end

	def move(x,y)
		@x2 = (@x + x)
		@y2 = (@y + y)
		
		if $map.blocked?(@x2, @y2) == false
			$map.set_tile(@x, @y, 'floor')
			@x = (@x + x)
			@y = (@y + y)
			$map.set_tile(@x, @y, 'monster') 
			#will need to change how set_tile works, somehow adjust it to reading what object is being passed into it (self)
			#add
		end
	end

	def move_towards(target_x, target_y)
		dx = target_x - x
		dy = target_y - y

		distance = Math.sqrt(dx ** 2 + dy ** 2)

		dx = (dx / distance).to_i.round
		dy = (dy / distance).to_i.round

		move(dx,dy)
	end
end