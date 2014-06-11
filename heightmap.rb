class HeightMap
	attr_accessor :width, :height

	def initialize(width, height)
		@width = width
		@height = height
		@map = Array.new(height){Array.new(width){0}}
	end
end