class Map
	attr_accessor :width, :height

	def initialize(width, height, window)
		@width = width
		@height = height
		@window = window
		@map = make_map
		@wall = Gosu::Image.new(window, './data/gfx/wall.png', false)
		@floor = Gosu::Image.new(window, './data/gfx/floor.png', false)
		@player = Gosu::Image.new(window, './data/gfx/knight.png', false)

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

	def set_tile(x, y, stat)
		if stat == 'wall'
			@map[x][y] = Tiles::Wall
		elsif stat == 'floor'
			@map[x][y] = Tiles::Floor
		elsif stat == 'player'
			@map[x][y] = Tiles::Player
		end
	end

	def create_h_tunnel(x1, x2, y)
		a = [x1, x2].min
		b = [x1, x2].max 

		(a...b).each do |x|
			@map[x][y] = Tiles::Floor

		end
	end

	def create_v_tunnel(y1, y2, x)
		a = [y1, y2].min
		b = [y1, y2].max 
		puts a
		puts b
		(a...b).each do |y|
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
					@wall.draw(x * 31 - 5, y * 31 - 5, 0)
				elsif tile == Tiles::Floor
					@floor.draw(x * 31 - 5, y * 31 - 5, 0)
				elsif tile == Tiles::Player
					@player.draw(x * 31 - 5, y * 31 - 5, 1)
				end
			end
		end
	end
end