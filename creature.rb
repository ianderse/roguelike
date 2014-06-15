require './gameobject.rb'
include Math

class Creature < GameObject
	attr_accessor :hp, :strength, :defense

	def initialize(window, map, x, y, object_name, blocks=false, hp, strength, defense)
		super(window, map, x, y, object_name, blocks=false)

		@hp = hp
		@defense = defense
		@strength = strength
	end

	def dead?
		if self.is_a?(Player)
			if self.hp <= 0
				true
			end
		else
			$monsters.each do |monster|
				if monster.hp <= 0
					$monsters.delete(monster)
					monster.clear
					true
				end
			end
		end
	end

	def take_damage(damage)
		@damage = damage
		if @damage > 0
			@hp -= @damage
		end
		if dead?
			puts name + ' is dead!'
		end
	end

	def attack(target)
		@damage = @strength - target.defense
		

		if @damage > 0
			puts self.name + ' attacks ' + target.name + ' for ' + @damage.to_s + ' damage'
			target.take_damage(@damage)
		else
			puts self.name + ' deals no damage!'
		end
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