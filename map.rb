class Map
	attr_accessor :width, :height, :player_x, :player_y

	def initialize(width, height, window)
		@width = width
		@height = height
		@window = window

		@map = init_map

		@color_dark_wall = Gosu::Color.rgba(0, 0, 100, 255)
		@color_light_wall = Gosu::Color.rgba(130, 110, 50, 255)
		@color_dark_ground = Gosu::Color.rgba(50,50,150, 255)
		@color_light_ground = Gosu::Color.rgba(200, 180, 50, 255)


		@wall = Gosu::Image.new(window, './data/gfx/wall.png', false)
		@floor = Gosu::Image.new(window, './data/gfx/floor.png', false)
		@player_tile = Gosu::Image.new(window, './data/gfx/knight.png', false)
	end

	def init_map	
		@map = Array.new(@width) do |x|
			Array.new(@height) do |y|
				Tiles::Wall
			end
		end
	end

	def make_map(max_rooms, room_min_size, room_max_size, map_width, map_height)
		
		rooms = Array.new(0)

		failed = false

		num_rooms = 0

		@player_x = @player_y = 0

		(0..max_rooms).each do |r|
			w = rand(room_min_size..room_max_size)
			h = rand(room_min_size..room_max_size)
			x = rand(0..map_width - w - 1)
			y = rand(0..map_height - h - 1)

			new_room = Rect.new(x, y, w, h)



			rooms.each do |other_room|
				if new_room.intersect(other_room) == true
					failed = true
					break
				else
					failed = false
				end
			end
			if failed == false
				create_room(new_room)
				(new_x, new_y) = new_room.center

				if num_rooms == 0
					@player_x = new_x
					@player_y = new_y
				else
					(prev_x, prev_y) = rooms[num_rooms-1].center

					if rand(0..1) == 1
						create_h_tunnel(prev_x, new_x, prev_y)
						create_v_tunnel(prev_y, new_y, new_x)
					else
						create_v_tunnel(prev_y, new_y, new_x)
						create_h_tunnel(prev_x, new_x, prev_y)
					end
				end
				rooms << new_room
				num_rooms += 1
			else
			end
		end
		set_tile(@player_x, @player_y, 'player')	
	end

	def create_h_tunnel(x1, x2, y)
		a = [x1, x2].min
		b = [x1, x2].max 

		(a..b).each do |x|
			@map[x][y] = Tiles::Floor

		end
	end

	def create_v_tunnel(y1, y2, x)
		a = [y1, y2].min
		b = [y1, y2].max 

		(a...b).each do |y|
			@map[x][y] = Tiles::Floor

		end
	end

	def create_room(room)
		a = (room.x1 + 1..room.x2)
		b = (room.y1 + 1..room.y2)

		 a.each do |x|
			b.each do |y|
				@map[x][y] = Tiles::Floor
			end
		end
	end

	def explored(x,y)
		#set tile to explored
	end

	def blocked?(x, y)
		if @map[x][y] == Tiles::Wall
			true
		else
			false
		end
	end

	def blocked_sight?(x, y)
		if @map[x][y] == Tiles::Wall
			true
		else
			false
		end
	end

	def visible?(x, y)
		#test to see if map tile is visible or not
		#if @map[x][y] == 
		true
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

	def draw
		@height.times do |y|
			@width.times do |x|
				tile = @map[x][y]
				if tile == Tiles::Wall
					if not visible?(x, y)
						@wall.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_dark_wall)
					else
						@wall.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_light_wall)
					end
				elsif tile == Tiles::Floor
					if not visible?(x,y)
						@floor.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_dark_ground)
					else
						@floor.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_light_ground)
					end
				elsif tile == Tiles::Player
					@floor.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_light_ground)
					@player_tile.draw(x * 31 - 5, y * 31 - 5, 1)
				end
			end
		end
	end
end