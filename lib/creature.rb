require './lib/gameobject.rb'
include Math

class Creature < GameObject
	attr_accessor :hp, :strength, :defense, :max_hp, :ai

	def initialize(window, x, y, object_name, blocks=false, max_hp, strength, defense)
		super(window, x, y, object_name, blocks=false)
		@max_hp = max_hp
		@hp = max_hp
		@defense = defense
		@strength = strength
		@ai = 'normal'
	end

	def dead?
		if self.is_a?(Player)
			if self.hp <= 0
				$game_state = 'dead'
				return true
			else
				return false
			end
		elsif self.is_a?(Monster)
			if self.hp <= 0
				$monsters.delete(self)
				self.clear
				return true
			else
				return false
			end
		end
	end

	def take_damage(damage)
		if damage > 0
			self.hp -= damage
		end
		if dead?
			Messager.message(name + ' is dead!')
		end
	end

	def attack(target)
		damage = (rand(5)+ @strength) - (rand(3) + target.defense)

		if damage > 0
			Messager.message(self.name + ' attacks ' + target.name + ' for ' + damage.to_s + ' damage')
			target.take_damage(damage)
		else
			Messager.message(name + ' deals no damage!')
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

		if $map_obj.blocked?(@x2, @y2) == false
			$map_obj.set_tile(@x, @y, 'floor')
			@x = (@x + x)
			@y = (@y + y)
			$map_obj.set_tile(@x, @y, 'monster')
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
