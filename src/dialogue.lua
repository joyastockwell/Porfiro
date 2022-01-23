local visible 		= require("visible")
local  Visible 		=  visible.Visible
local  COLOR_BLACK	=  visible.COLOR_BLACK
local  COLOR_WHITE	=  visible.COLOR_WHITE

local class 		= require("useful.class")
local  Class		=  class.Class

local visible 		= require("visible")
local  Text			=  visible.Text
local  Visible  	=  visible.Visible

local physical 		= require("physical")
local  Block		= physical.Block
local  Physical 	= physical.Physical

local menu 		= require("menu")

local dialogue = { }

dialogue.Bubble = Class(Visible, menu.MenuItem, {
	new = function(self, initializer)
		self.x = initializer.x
		self.y = initializer.y

		self.action = initializer.action

		
		self._text = Text({
			font = initializer.font,
			string = initializer.text
		})
		
		local x_margin = initializer.x_margin or 0 
		local y_margin = initializer.y_margin or 0 

		self._width = initializer.width --self._text:get_width() + (x_margin * 2)
		self._height = initializer.height --self._text:get_height() + (y_margin * 2) 

		self._text:set_position(self.x + x_margin, self.y + y_margin)

		color = initializer.color
		self.color = color

		-- initializer.width = self.width
		-- initializer.height = self.height
		-- initializer.color = color
		self._object = Block(initializer)
	end,

	type = function()
		return "bubble"
	end,

	get_string = function(self)
		return self._text:get_string()
	end,

	on_primary_click = function(self)
		print("shmall!")
		if self.action ~= nil then
			self.action()
		end
		print("shmeep!")
	end,
	
	draw = function(self)
		self._object:draw()
		self._text:draw()
	end,
})

return dialogue