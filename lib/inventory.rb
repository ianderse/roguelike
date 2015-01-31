class Inventory
	def initialize(window)
		@window = window
	end

	def draw
		y = 50
		alphabet = ('a'..'z').to_a
		a_index = 0

		$font.draw("- - - Inventory - - -", $window_width/2 - 150, 0, 1, 2.0, 2.0, $white)
		$font.draw("ESC to close", $window_width/2 - 120, 40, 1, 2.0, 2.0, $white)
		$bag.each do |item|
			$font.draw(alphabet[a_index] + ')', 1, 20+y, 1, 1.5, 1.5, $white)
			$font.draw(item.name.capitalize, 50, 20+y, 1, 1.5, 1.5, $white)
			y += 50
			a_index += 1
		end
	end
end
