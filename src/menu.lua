local insert		= table.insert
local remove		= table.remove

local class 		= require("useful.class")
local  Class		=  class.Class

local get_global_color	= love.graphics.getColor
local get_global_font	= love.graphics.getFont
local get_mouse_x 	= love.mouse.getX
local get_mouse_y	= love.mouse.getY
local love_draw		= love.graphics.draw
local new_text		= love.graphics.newText
local new_image		= love.graphics.newImage

local visible 		= require("visible")
local  Image 		=  visible.Image
local  Text		=  visible.Text
local  Visible  	=  visible.Visible

local physical 		= require("physical")
local  Block		= physical.Block
local  Physical 	= physical.Physical

local menu = { }

menu.MenuItem = Class {
	on_hover_over = function(self)
	end,
	
	on_hover_leave = function(self)
	end,

	on_primary_click = function(self)
	end,

	on_secondary_click = function(self)
	end,

	on_tertiary_click = function(self)
	end,
}
	
menu.Cursor = Class(Visible, Physical, {
	new = function(self, image_file, x, y)
		self.x = x
		self.y = y
		
		self._image = new_image(image_file)
		
		self.width = self._image:getWidth()
		self.height = self._image:getHeight()

		self._hover_overs = { }
	end,

	type = function()
		return "cursor"
	end,

	update_position = function(self)
		if (self._world == nil) then
			return
		end

		local function collide(item, other)
			if other.type() == "button" then
				if not self._hover_overs[other] then
					other:on_hover_over()
					self._hover_overs[other] = true
				end
			end

			return "cross"
		end
		
		self.x = get_mouse_x()
		self.y = get_mouse_y()
	
		local _,_, cols = self._world:move(self, self.x, self.y, collide)

		-- Flag all items that appear in the "collision" (i.e. 
		-- objects the mouse is hovering over. The boolean value
		-- is meaningless here and used only for
		-- flagging purposes
		for _, col in ipairs(cols) do
			self._hover_overs[col.other] = false
		end

		-- Unflagged entries are not currently being hovered
		-- over, so we remove them from the list of ones that
		-- are. Also reset the flagged values so they exhibit
		-- proper behavior during the next collision check 
		for object, flag in pairs(self._hover_overs) do
			if flag == true then
				self._hover_overs[object] = nil		
				if object.type() == "button" then
					object:on_hover_leave()	
				end
			else
				self._hover_overs[object] = true
			end
		end
	end,

	handle_mouse_press = function(self, button)
		if button == 1 then
			for object,_ in pairs(self._hover_overs) do
				object:on_primary_click()
			end
		elseif button == 2 then
			for object,_ in pairs(self._hover_overs) do
				object:on_secondary_click()
			end

		elseif button == 3 then
			for object,_ in pairs(self._hover_overs) do
				object:on_tertiary_click()
			end

		end		
	end,
	
	draw = function(self)
		love_draw(self._image, self.x, self.y)
	end
})

menu.Button = Class(Visible, Physical, menu.MenuItem, {
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

		local width = self._text:get_width() + (x_margin * 2)
		local height = self._text:get_height() + (y_margin * 2) 

		local min_width = initializer.min_width 
		local min_height = initializer.min_height

		if min_width ~= nil and min_width > width then
			self.width = min_width
		else
			self.width = width 
		end

		if min_height ~= nil and min_height > height then
			self.height = min_height
		else
			self.height = height
		end

		self._text:set_position(self.x + x_margin, self.y + y_margin)

		color = initializer.color or {get_global_color()}
		self.color = color
		self._old_color = {color[1], color[2], color[3]} 

		initializer.width = self.width
		initializer.height = self.height
		initializer.color = color
		self._object = Block(initializer)
	end,

	type = function()
		return "button"
	end,

	get_string = function(self)
		return self._text:get_string()
	end,

	on_primary_click = function(self)
		if self.action ~= nil then
			self.action()
		end
	end,

	on_hover_over = function(self)
		local DARKEN_RATIO = 0.9 -- Darken by 10 %
		local function darken()		
			local color = self.color
		
			for index, component in ipairs(color) do
				color[index] = component * DARKEN_RATIO
			end

			return color
		end

		local new_color = darken()
		self.color = new_color
		self._object:set_color(new_color)	
	end,
		
	on_hover_leave = function(self)
		local color = self._old_color
		self.color = {color[1], color[2], color[3]}
		self._object:set_color(self.color)
	end,
	
	draw = function(self)
		self._object:draw()
		self._text:draw()
	end,
})

return menu
