require './lib/monster'
require './lib/fov'

include PermissiveFieldOfView

class Map
	attr_accessor :width, :height, :player_x, :player_y

	def initialize(width, height, window)
		@width = width
		@height = height
		@window = window

		@max_room_monsters = 3
		@max_room_items = 2

		@color_dark_wall = Gosu::Color.rgba(255,0,0, 0)
		@color_light_wall = Gosu::Color.rgba(130, 110, 50, 255)
		@color_dark_ground = Gosu::Color.rgba(255,0,0, 0)
		@color_light_ground = Gosu::Color.rgba(200, 180, 50, 255)
		@color_dark_monster = Gosu::Color.rgba(255,0,0, 0)

		@wall = $image_tiles[18]
		@floor = $image_tiles[19]
		@player_tile = $image_tiles[149]
	end

	def place_objects(room)

		choice = rand(100)
		num_monsters = rand(0..@max_room_monsters)
		num_items = rand(0...@max_room_items)

		(0..num_monsters).each do |i|
			choice = rand(100)
			x = rand(room.x1..room.x2)
			y = rand(room.y1..room.y2)
			if blocked?(x,y) == false
				if rand(100) < 80
					if choice < 20
						@monster = Monster.new(@window, x, y, 'bat', true, 5, 0, 2)
					elsif choice > 20 && choice < 40
						@monster = Monster.new(@window, x, y, 'orc', true, 15, 2, 5)
					elsif choice > 40 && choice < 60
						@monster = Monster.new(@window, x, y, 'spider', true, 7, 1, 3)
					else
						@monster = Monster.new(@window, x, y, 'gecko', true, 10, 1, 4)
					end
				set_tile(x,y,'monster')
				$monsters << @monster
				end	
			end
		end

		(0..num_items).each do |i|
			choice = rand(100)
			x = rand(room.x1..room.x2)
			y = rand(room.y1..room.y2)

			if blocked?(x,y) == false
				if choice > 70
					item = Item.new(@window, x, y, 'healing potion', false)
					$items << item
				else
					item = Scroll.new(@window, x, y, 'lightning scroll', false)
					$items << item
				end
			end
		end

	end

	def init_map	
		Array.new(@width) do |x|
			Array.new(@height) do |y|
				Tiles::Unlit_Wall
			end
		end
	end

	def explored(x,y)
		#set tile to explored
	end

	def blocked?(x, y)
		if $map[x][y] == Tiles::Wall || $map[x][y] == Tiles::Unlit_Wall
			true
		elsif $map[x][y] == Tiles::Monster || $map[x][y] == Tiles::Unlit_Monster
			true
		else
			false
		end
	end

	def light(x,y)
		set_tile(x,y, 'lit')
	end



	def blocked_sight?(x, y)
		if $map[x][y] == Tiles::Wall
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

	def attackable?(x, y)
		if $map[x][y] == Tiles::Monster || $map[x][y] == Tiles::Unlit_Monster
			true
		else
			false
		end
	end

	def whats_there?(x, y)
		tile = $map[x][y]

		if tile == Tiles::Monster
			$monsters.each do |monster|
				if monster.x == x && monster.y == y
					return monster
				end
			end
		end
	end

	def set_tile(x, y, stat)
		if stat == 'wall'
			$map[x][y] = Tiles::Unlit_Wall
		elsif stat == 'floor'
			$map[x][y] = Tiles::Unlit_Floor
		elsif stat == 'player'
			$map[x][y] = Tiles::Player
		elsif stat == 'monster'
			$map[x][y] = Tiles::Unlit_Monster
		elsif stat == 'lit'
			if $map[x][y] == Tiles::Unlit_Wall
				$map[x][y] = Tiles::Wall
			elsif $map[x][y] == Tiles::Unlit_Floor
				$map[x][y] = Tiles::Floor
			elsif $map[x][y] == Tiles::Unlit_Monster
				$map[x][y] = Tiles::Monster
			end
		end
	end

	def draw
		@height.times do |y|
			@width.times do |x|
				tile = $map[x][y]
				if tile == Tiles::Wall
					@wall.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_light_wall)
				elsif tile == Tiles::Unlit_Wall
					@wall.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_dark_wall)
				elsif tile == Tiles::Item
					@floor.draw(x * 31, y * 31, 0, 1, 1)
				elsif tile == Tiles::Unlit_Floor
					@floor.draw(x * 31 - 5, y * 31 - 5, 0, 1, 1, color = @color_dark_ground)
				elsif tile == Tiles::Floor
					@floor.draw(x * 31, y * 31, 0, 1, 1)#, color = @color_light_ground)
				elsif tile == Tiles::Player
					@floor.draw(x * 31, y * 31, 0, 1, 1)#, color = @color_light_ground)
					@player_tile.draw(x * 31 - 5, y * 31 - 5, 2, 1, 1, color = @color_light_ground)
				elsif tile == Tiles::Unlit_Monster
					@floor.draw(x * 31, y * 31, 0, 1, 1, color = @color_dark_ground)
				elsif tile == Tiles::Monster
				 	@floor.draw(x * 31, y * 31, 0, 1, 1)#, color = @color_light_ground)
				end
			end
		end
	end
end