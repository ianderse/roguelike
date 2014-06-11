module Tiles
	Wall = 1
	Floor = 0
end

class Rect
	attr_accessor :x1, :x2, :y1, :y2

	def initialize(window, x, y, w, h)
		@x1 = x
		@y1 = y
		@x2 = x + w
		@y2 = y + h
	end
end