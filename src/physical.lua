local class 		= require("useful.class")
local  Class		=  class.Class

local draw_rect		= love.graphics.rectangle
local get_global_color 	= love.graphics.getColor
local set_global_color	= love.graphics.setColor

local visible 		= require("visible")
local  Visible 		=  visible.Visible

local physical = { }

physical.Physical = Class {
	set_bump_world = function(self, world) 
		self._bump_world = world
	end,

	unset_bump_world = function(self) 
		self._bump_world = nil
	end,

	type = function()
		return "physical"
	end
}

physical.VerticalBound = Class(physical.Physical, { 
	new = function(self, x, y, height)
		self.x = x
		self.y = y
		self.width = 1
		self.height = height
	end
})

physical.Block = Class(Visible, physical.Physical, {
	new = function(self, initializer)
		self.x = initializer.x
		self.y = initializer.y

		self.width = initializer.width
		self.height = initializer.height

		local x_curve = initializer.x_curve or 0
		local y_curve = initializer.y_curve or 0

		self.rx = self.width * (x_curve / 2) 
		self.ry = self.height * (y_curve /2 )

		self.color = initializer.color or {get_global_color()}
		self.mode = initializer.mode or "fill"
	end,
	
	set_color = function(self, color)
		self.color = color
	end,

	draw = function(self)
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

return physical
