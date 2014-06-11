class Player

	attr_accessor :x, :y

	def initialize(window)
		@image = Gosu::Image.new(window, './data/gfx/knight.png', false)
		@x = @y = 0
	end

	def draw
		@image.draw(@x, @y, 0)
	end
end