class GameObject

	attr_accessor :x, :y, :name

	def initialize(window, map, x, y, object_name, blocks=false)
		@x = x
		@y = y
		@map = map
		@name = object_name
		@blocks = blocks
	end

	def move(x1, y1)

	end

	def is_blocked?
		if @blocks == true
			true
		else
			false
		end
	end

	def clear
		@map.set_tile(@x, @y, 'floor')
	end

end