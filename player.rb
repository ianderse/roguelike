class Player

	attr_accessor :x, :y

	def initialize(window, map)
		@map = map
		@image = Gosu::Image.new(window, './data/gfx/knight.png', false)
		@x = @y = 320
	end

	def draw
		@image.draw(@x, @y, 0)
	end

	def move(x1, y1)
		@x2 = @x + x1
		@y2 = @y + y1
		if @map.blocked?(@x2, @y2) == false
			@x += x1
			@y += y1
		end
		puts @x1
		puts @x2
	end
end