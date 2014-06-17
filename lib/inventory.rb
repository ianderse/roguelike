class Inventory
	def initialize(window)
		@window = window
	end

	def toggle
		if $game_state == 'inventory'
			$game_state = 'playing'
		elsif $game_state == 'playing'
			$game_state = 'inventory'
		end
	end

	def move(direction)
		case direction
			when direction = :up
			when direction = :down
			when direction = :left
			when direction = :right
		end
	end

	def draw
		y = 50
		alphabet = ('a'..'z').to_a
		a_index = 0

		$font.draw("- - - Inventory - - -", $window_width/2 - 150, 0, 1, 2.0, 2.0, $white)
		$font.draw("ESC to close", $window_width/2 - 120, 40, 1, 2.0, 2.0, $white)
		$bag.each do |item|
			$font.draw(alphabet[a_index] + ')', 1, 20+y, 1, 1.5, 1.5, $white)
			$font.draw(item.name, 50, 20+y, 1, 1.5, 1.5, $white)
			y += 50
			a_index += 1
		end
	end

	def convert_button(id)
		case id
			when 0
				return 97
			when 11
				return 98
			when 8
				return 99
			when 2
				return 100
			when 14
				return 101
			when 3
				return 102
			when 5
				return 103
			when 4
				return 104
			when 34
				return 105
			when 38
				return 106
			when 40
				return 107
			when 37
				return 108
			when 46
				return 109
			when 45
				return 110
			when 31
				return 111
			when 35
				return 112
			when 12
				return 113
			when 15
				return 114
			when 1
				return 115
			when 17
				return 116
			when 32
				return 117
			when 9
				return 118
			when 13
				return 119
			when 7
				return 120
			when 16
				return 121
			when 6
				return 122
			else
				return 0
		end
	end

	def button_handle(id)
		if id == Gosu::Button::KbEscape
			toggle
		elsif id == Gosu::Button::KbLeft
			move(:left)
		elsif id == Gosu::Button::KbRight
			move(:right)
		elsif id == Gosu::Button::KbUp
			move(:up)
		elsif id == Gosu::Button::KbDown
			move(:down)
		else
			index = convert_button(id) - 'a'.ord
			if $bag[index] != nil
				$bag[index].use
			end
		end
	end
end