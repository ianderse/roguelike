class Inventory
	def initialize(window)
		@font = Gosu::Font.new(window, Gosu::default_font_name, 20)
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
		@font.draw("- - - Inventory - - -", $window_width/2 - 150, 0, 1, 2.0, 2.0, $white)
	end
end