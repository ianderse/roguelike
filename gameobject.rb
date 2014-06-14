class GameObject

	attr_accessor :x, :y

	def initialize(window, map, x, y, object_name)
		@x = x
		@y = y
		@map = map
		if object_name == 'player'
			@image = $image_tiles[149]
		elsif object_name == 'orc'
			@image = $image_tiles[149]
		end
	end

	def move(x1, y1)

		@x2 = (@x + x1)
		@y2 = (@y + y1)

		if @map.blocked?(@x2, @y2) == false
			@map.set_tile(@x, @y, 'floor')
			@x = (@x + x1)
			@y = (@y + y1)
			@map.set_tile(@x, @y, 'player') 
			#will need to change how set_tile works, somehow adjust it to reading what object is being passed into it (self)
			#add check to see if player walks off screen
		end
	end

	def clear
		@map.set_tile(@x, @y, 'floor')
	end

end