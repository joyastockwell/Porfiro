local insert		= table.insert

local class 		= require("useful.class")
local  Class		=  class.Class

local draw_polygon	= love.graphics.polygon
local draw_rect 	= love.graphics.rectangle
local draw_circle	= love.graphics.circle 
local love_draw		= love.graphics.draw
local get_global_color 	= love.graphics.getColor 
local set_global_color	= love.graphics.setColor
local get_global_font	= love.graphics.getFont
local new_font		= love.graphics.newFont
local new_image		= love.graphics.newImage
local new_text 		= love.graphics.newText

local math_ext		= require("math_ext")
local  cos		=  math_ext.cos
local  sin		=  math_ext.sin
local  tan		=  math_ext.tan

local visible = { }

visible.COLOR_BLACK 	= {0, 0, 0}
visible.COLOR_RED	= {1, 0, 0}
visible.COLOR_GREEN	= {0, 1, 0}
visible.COLOR_BLUE	= {0, 0, 1}
visible.COLOR_WHITE	= {1, 1, 1}

visible.Visible = Class {
	draw = function(self) -- luacheck: ignore
	end
}

visible.Rectangle = Class(visible.Visible, { 
	new = function(self, initializer)
		self.x = initializer.x 
		self.y = initializer.y 

		self.width = initializer.width
		self.height = initializer.height	

		local width = self.width
		local height = self.height
		local x_curve = initializer.x_curve or 0
		local y_curve = initializer.y_curve or 0

		self.rx = width * (x_curve / 2) 
		self.ry = height * (y_curve /2 )

		self.color = initializer.color or { get_global_color() }

		self.mode = initializer.mode or "fill"
	end,
		
	set_color = function(self, color)
		self.color = color
	end,

	draw = function(self, x, y)
		local xx = x or self.x
		local yy = y or self.y
		
		local last_color = {get_global_color()}	
		set_global_color(unpack(self.color))

		local width = self.width
		local height = self.height
		local rx = self.rx
		local ry = self.ry
		local mode = self.mode
		draw_rect(mode, xx, yy, width, height, rx, ry)
		
		set_global_color(unpack(last_color))
	end
})

visible.Circle = Class(visible.Visible, { 
	new = function(self, x, y, radius, color, mode)
		self.x = x
		self.y = y
		self.radius = radius	

		self.color = color or {get_global_color()}
		self.mode = mode or "fill"
	end,

	draw = function(self, x, y)
		local xx = x or self.x
		local yy = y or self.y

		local last_color = { get_global_color() }	
		set_global_color(unpack(self._color))
	
		draw_circle(self.mode, xx, yy, self.radius)	
			
		set_global_color(unpack(last_color))
	end
})

visible.Polygon = Class(visible.Visible, {
	new = function(self, vertices, color, draw_mode)
		self.vertices = vertices 
		self.color = color or {get_global_color()}
		self.draw_mode = draw_mode or "fill"
	end,

	draw = function(self)
		local last_color = {get_global_color()}	
		set_global_color(unpack(self.color))

		draw_polygon(self.draw_mode, self.vertices)		

		set_global_color(unpack(last_color))
	end
})

visible.IsocelesTrapezoid = Class(visible.Polygon, {
	new = function(self, x, y, width, height, angle, color, draw_mode)
		print("Dviding this time")
		self.vertices = {x, y}			
		print(x, y)

		print("angle:", angle)
		print("tan", tan(angle))
		print("h * tan:", height * tan(angle))
		print("h / tan:", height / tan(angle))
		local x_n = x + (height / tan(angle))
		insert(self.vertices, x_n)
		insert(self.vertices, y + height)
		print(x_n, y + height)

		x_n = x + width - (height / tan(angle))
		insert(self.vertices, x_n)
		insert(self.vertices, y + height)
		print(x_n, y + height)
		
		insert(self.vertices, x + width)
		insert(self.vertices, y)
		print(x + width, y)

		self.color = color or {get_global_color()}
		self.draw_mode = draw_mode or "fill"
	end
})

visible.Image = Class(visible.Visible, {
	new = function(self, image_file, x, y)
		self.x = x
		self.y = y
	
		self._image = new_image(image_file)
	end,

	get_width = function(self)
		return self._image:getWidth()
	end,

	get_height = function(self)
		return self._image:getHeight()
	end,
	
	draw = function(self)
		love_draw(self._image, self.x, self.y)
	end
})

visible.Text = Class(visible.Visible, {
	new = function(self, initializer)
		self.x = initializer.x
		self.y = initializer.y

		self._str = initializer.string
	
		if initializer.font ~= nil then
			self._font_path = initializer.font.filename
			self._font_size = initializer.font.size
			self._font = new_font(self._font_path, self._font_size)
		else
			self._font = get_global_font()
		end

		self._text = new_text(self._font, self._str)
	end,
	
	get_width = function(self)
		return self._text:getWidth()	
	end,
		
	get_height = function(self)
		return self._text:getHeight()
	end,

	get_string = function(self)
		return self._str
	end,

	get_font_size = function(self)
		return self._font_size or -1
	end,
	
	get_font_path = function(self)
		return self._font_path or "unknown"
	end,

	set_position = function(self, x, y)
		self.x = x
		self.y = y	
	end,

	draw = function(self)
		local xx = x or self.x
		local yy = y or self.y
		
		local last_color = { get_global_color() }	
		set_global_color(0, 0, 0)
	
		love_draw(self._text, xx, yy)
		
		set_global_color(unpack(last_color))
	end
})

return visible
