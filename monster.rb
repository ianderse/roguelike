require './gameobject.rb'

class Monster < GameObject
	def initialize(window, map, x, y, object_name, blocks=false)
		super
		@x = x
		@y = y
		@map = map

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

	def draw
		@image.draw(@x * 31 - 5, @y * 31 - 5, 2, 1, 1)
	end
end