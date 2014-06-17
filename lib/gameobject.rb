class GameObject

	attr_accessor :x, :y, :name, :blocks, :window

	def initialize(window, x, y, object_name, blocks=false)
		@window = window
		@x = x
		@y = y
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
		$map_obj.set_tile(@x, @y, 'floor')
	end

end