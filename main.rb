require 'gosu'
require './map'
require './player'
require './tile'


class GameWindow < Gosu::Window
	def initialize
		super(1900, 1080, false)

		self.caption = "Ruby Roguelike"

		map_width = 65
		map_height = 40

		room_max_size = 10
		room_min_size = 6
		max_rooms = 10

		player_x = player_y = 0

		failed = false

		@map = Map.new(map_width, map_height, self)

		rooms = Array.new(0)

		num_rooms = 0

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
			puts failed
			if failed == false
				@map.create_room(new_room)
				(new_x, new_y) = new_room.center

				if num_rooms == 0
					player_x = new_x
					player_y = new_y
				else
					(prev_x, prev_y) = rooms[num_rooms-1].center

					if rand(0..1) == 1
						@map.create_h_tunnel(prev_x, new_x, prev_y)
						@map.create_v_tunnel(prev_y, new_y, new_x)
					else
						@map.create_v_tunnel(prev_y, new_y, new_x)
						@map.create_h_tunnel(prev_x, new_x, prev_y)
					end
				end
				rooms << new_room
				num_rooms += 1
			else
				puts "failed, sorry"
			end

		end

		@player = Player.new(self, @map, player_x, player_y)
		@map.set_tile(player_x, player_y, 'player')	
	end

	def update
	end

	def draw
		@map.draw
	end

	def button_down(id)
		case id
			when Gosu::Button::KbEscape
				self.close
			when Gosu::Button::KbLeft
				@player.move(-1,0)
			when Gosu::Button::KbRight
				@player.move(1, 0)
			when Gosu::Button::KbUp
				@player.move(0, -1)
			when Gosu::Button::KbDown
				@player.move(0, 1)
			end
		end
end

window = GameWindow.new.show