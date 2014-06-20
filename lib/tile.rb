module Tiles
	Item = 4
	Monster = 3
	Unlit_Monster = -3
	Player = 2
	Wall = 1
	Unlit_Wall = -2
	Floor = 0
	Unlit_Floor = -1
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
end