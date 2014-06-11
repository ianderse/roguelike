require './tile'

class Map
	attr_accessor :width, :height

	def initialize(width, height, window)
		@width = width
		@height = height
		@window = window
		@tiles = make_map
		@wall = Gosu::Image.new(window, './data/gfx/wall.png', false)
		@floor = Gosu::Image.new(window, './data/gfx/floor.png', false)
		@tile_size = 32

		make_map
	end

	def create_room(room)
	end

	def make_map
		@i = @j = 0
		
		# @tiles = Array.new(@width) do |x|
		# 	Array.new(@height) do |y|
		# 		#if rand(100) < 50
		# 		#	Tiles::Wall
		# 		#else
		# 			Tiles::Floor
		# 		#end
		# 	end
		# end

		return @map
	end

	def set_wall_tile(x, y, stat)
		if stat == true
			@tiles[x][y] = Tiles::Wall
		else
			@tiles[x][y] = Tiles::Floor
		end
	end

	def draw
		@height.times do |y|
			@width.times do |x|
				tile = @tiles[x][y]
				if tile == Tiles::Wall
					@wall.draw(x * 50 - 5, y * 50 - 5, 0)
				else
					@floor.draw(x * 50 - 5, y * 50 - 5, 0)
				end
			end
		end
	end
end