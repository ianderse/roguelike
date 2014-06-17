class Item < GameObject
	def initialize(window, x, y, object_name, blocks=false)
		super
		if name == 'healing potion'
			@healing_amount = 4
			@image = $image_tiles[40]
		end
	end

	def pick_up
		if $bag.length >= 26
			@window.message("Inventory is full!")
		else
			$bag << self
			$items.delete(self)
			@window.message("You picked up a " + self.name)
		end

		$monsters.each do |monster|
			monster.take_turn
		end
	end

	def use
		if name == 'healing potion'
			if $player.hp == $player.max_hp
				@window.message("Already at full health!")
			elsif $player.hp + @healing_amount < $player.max_hp
				$player.hp += @healing_amount
				$bag.delete(self)
				@window.message("Used a " + name)
			else
				$player.hp = $player.max_hp
				$bag.delete(self)
				@window.message("Used a " + name)
			end
		end
	end

	def draw
		@image.draw(@x * 31 - 5, @y * 31 - 5, 1, 1, 1)
	end
end