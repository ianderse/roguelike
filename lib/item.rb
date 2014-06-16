class Item < GameObject
	def initialize(window, map, x, y, object_name, blocks=false)
		super

		if object_name == 'healing potion'
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

	end

	def draw
		@image.draw(@x * 31 - 5, @y * 31 - 5, 1, 1, 1)
	end
end