class Object

	attr_accessor :x, :y

	def initialize(window, map, x, y)
		@x = x
		@y = y
		@map = map
	end

	def move(x1, y1)

		@x2 = (@x + x1)
		@y2 = (@y + y1)

		if @map.blocked?(@x2, @y2) == false
			@map.set_tile(@x, @y, 'floor')
			@x = (@x + x1)
			@y = (@y + y1)
			@map.set_tile(@x, @y, 'player')
		#add check to see if player walks off screen
		end
	end

	def clear
		@map.set_tile(@x, @y, 'floor')
	end

end