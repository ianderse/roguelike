class Map
	attr_accessor :width, :height

	def initialize(width, height, window)
		@width = width
		@height = height
		@window = window
		@map = make_map
		@wall = Gosu::Image.new(window, './data/gfx/wall.png', false)
		@floor = Gosu::Image.new(window, './data/gfx/floor.png', false)

		make_map
	end

	def blocked?(x, y)
		if @map[x][y] == Tiles::Wall
			true
		else
			false
		end
	end

	def make_map
		
		@map = Array.new(@width) do |x|
			Array.new(@height) do |y|
				Tiles::Wall
			end
		end
	end

	def set_wall_tile(x, y, stat)
		if stat == true
			@map[x][y] = Tiles::Wall
		else
			@map[x][y] = Tiles::Floor
		end
	end

	def create_room(room)
		a = (room.x1 + 1...room.x2)
		b = (room.y1 + 1...room.y2)

		 a.each do |x|
			b.each do |y|
				@map[x][y] = Tiles::Floor
			end
		end
	end

	def draw
		@height.times do |y|
			@width.times do |x|
				tile = @map[x][y]
				if tile == Tiles::Wall
					@wall.draw(x * 32 - 3, y * 32 - 3, 0)
				else
					@floor.draw(x * 32 - 3, y * 32 - 3, 0)
				end
			end
		end
	end
end