module Tiles
	Monster = 3
	Player = 2
	Wall = 1
	Floor = 0
end

class Rect
	attr_accessor :x1, :x2, :y1, :y2

	def initialize(x, y, w, h)
		@x1 = x
		@y1 = y
		@x2 = x + w
		@y2 = y + h
	end

	def center
		@center_x = (self.x1 + self.x2) / 2, @center_y = (self.y1 + self.y2) / 2
	end

	def intersect(other)
		if (self.x1 - 6 <= other.x2 and self.x2 >= other.x1 - 6 and
			self.y1 - 6 <= other.y2 and self.y2 >= other.y2 - 6)
			true
		else
			false
		end
	end
end