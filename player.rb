class Player

	attr_accessor :x, :y

	def initialize(window, map, x, y)
		@x = x
		@y = y
		@player_x_test = @player_x
		@player_y_test = @player_y
		@map = map
	end

	# def draw
	# 	@image.draw(@x, @y, 0)
	# end

	def move(x1, y1)

		@x2 = (@x + x1)
		@y2 = (@y + y1)

		if @map.blocked?(@x2, @y2) == false
			@map.set_tile(@x, @y, 'floor')
			@x = (@x + x1)
			@y = (@y + y1)
			@map.set_tile(@x, @y, 'player')
		end
	end
end