class Leaf

	attr_accessor :x, :y, :w, :h, :leftChild, :rightChild

	def initialize(x,y,w,h)
		@x = x
		@y = y
		@w = w
		@h = h

		@min_leaf_size= 7
		@splitH = false
		@max = 0

		@leftChild = @rightChild = nil
		
		@wall = $image_tiles[18]
		@floor = $image_tiles[19]

	end

	def create_leafs
			max_leaf_size = 10
			l_leaf = nil
			did_split = true

			root_leaf = Leaf.new(0,0, $map_width, $map_height)

			$leafs << root_leaf

			while did_split == true do
				did_split = false
				$leafs.each do |l|
					if l.leftChild == nil && l.rightChild == nil
						if l.w > max_leaf_size || l.h > max_leaf_size || rand(0.0..1.0) > 0.25
							if l.split == true
								$leafs << l.leftChild
								$leafs << l.rightChild
								did_split = true
							end
						end
					end
				end
			end
			root_leaf.create_rooms
	end

	def split
		if @leftChild != nil || @rightChild != nil
			return false
		end

		if (@w > @h) #&& (@h / @w >= 0.05)
			@splitH = false
		elsif (@h > @w)# && (@w / @h >= 0.05)
			@splitH = true
		end

		if @splitH == true
			@max = @h - @min_leaf_size
		else
			@max = @w - @min_leaf_size
		end

		if @max <= @min_leaf_size
			return false
		end

		split_num = rand(@min_leaf_size..@max)

		if @splitH
			@leftChild = Leaf.new(@x, @y, @w, split_num)
			@rightChild = Leaf.new(@x, @y + split_num, @w, @h - split_num)
		else
			@leftChild = Leaf.new(@x, @y, split_num, @h)
			@rightChild = Leaf.new(@x + split_num, @y, @w - split_num, @h)
		end

		true
	end


	def create_rooms

		if leftChild != nil || rightChild != nil
			if leftChild != nil
				leftChild.create_rooms
			end
			if rightChild != nil
				rightChild.create_rooms
			end
			if leftChild != nil && rightChild != nil
				create_hall(leftChild.get_room, rightChild.get_room)
			end
		else
			room_size_x = rand(3..@w-2)
			room_size_y = rand(3..@h-2)
			room_pos_x = rand(1..@w-room_size_x - 1)
			room_pos_y = rand(1..@h-room_size_y - 1)

			@room = Rect.new(@x + room_pos_x, @y + room_pos_y, room_size_x, room_size_y)

			if $first_room == true
				new_x, new_y = @room.center
				$player_x = new_x
				$player_y = new_y
				$first_room = false
			end
			
			a = (@room.x1 + 1..@room.x2)
			b = (@room.y1 + 1..@room.y2)

			a.each do |x|
				b.each do |y|
					$map[x][y] = Tiles::Unlit_Floor
				end
			end
			$map_obj.place_objects(@room)
		end
	end

	def get_room
		if @room != nil
			return @room
		else
			if leftChild != nil
				l_room = leftChild.get_room
			end
			if rightChild != nil
				r_room = rightChild.get_room
			end
			if l_room == nil && r_room == nil
				return nil
			elsif r_room == nil
				return l_room
			elsif l_room == nil
				return r_room
			elsif rand(0.0..1.0) > 0.5
				return l_room
			else
				return r_room
			end
		end
	end

	def create_hall(l, r)
		halls = []

		point1_x = rand(l.x1 + 1..l.x2 - 2)
		point1_y = rand(l.y1 + 1..l.y2 - 2)

		point2_x = rand(r.x1 + 1..r.x2 - 2)
		point2_y = rand(r.y1 + 1..r.y2 - 2)

		width = point2_x - point1_x
		height = point2_y - point1_y

		if width < 0
			if height < 0
				if rand(0.0..1.0) * 0.5
					halls << Rect.new(point2_x, point1_y, width.abs, 1)
					halls << Rect.new(point2_x, point2_y, 1, height.abs)
				else
					halls << Rect.new(point2_x, point2_y, width.abs, 1)
					halls << Rect.new(point1_x, point2_y, 1, height.abs)
				end
			elsif height > 0
				if rand(0.0..1.0) * 0.5
					halls << Rect.new(point2_x, point1_y, width.abs, 1)
					halls << Rect.new(point2_x, point1_y, 1, height.abs)
				else
					halls << Rect.new(point2_x, point2_y, width.abs, 1)
					halls << Rect.new(point1_x, point1_y, 1, height.abs)
				end
			else
				halls << Rect.new(point2_x, point2_y, width.abs, 1)
			end
		elsif width > 0
			if height < 0
				if rand(0.0..1.0) * 0.5
					halls << Rect.new(point1_x, point2_y, width.abs, 1)
					halls << Rect.new(point1_x, point2_y, 1, height.abs)
				else
					halls << Rect.new(point1_x, point1_y, width.abs, 1)
					halls << Rect.new(point2_x, point2_y, 1, height.abs)
				end
			elsif height > 0
				if rand(0.0..1.0) * 0.5
					halls << Rect.new(point1_x, point1_y, width.abs, 1)
					halls << Rect.new(point2_x, point1_y, 1, height.abs)
				else
					halls << Rect.new(point1_x, point2_y, width.abs, 1)
					halls << Rect.new(point1_x, point1_y, 1, height.abs)
				end
			else
				halls << Rect.new(point1_x, point1_y, width.abs, 1)
			end
		else
			if height < 0
				halls << Rect.new(point2_x, point2_y, 1, height.abs)
			elsif height > 0
				halls << Rect.new(point1_x, point1_y, 1, height.abs)
			end
		end

		halls.each do |hall|
			a = [hall.x1, hall.x2].min
			b = [hall.x1, hall.x2].max - 1

			a1 = [hall.y1, hall.y2].min
			b1 = [hall.y1, hall.y2].max - 1

			(a..b).each do |x|
				(a1..b1).each do |y|
					$map[x][y] = Tiles::Unlit_Floor
				end
			end
		end
	end
end