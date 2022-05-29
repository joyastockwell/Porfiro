local insert	= table.insert

local class	= require("useful.class")
local  Class	=  class.Class

local bump 	= require("bump")

local world = { }

world.World = Class {
	new = function(self)
		self._bump_world = bump.newWorld()
		self._draw_list = { }
	end,

	add_physical = function(self, physical)
		local x = physical.x
		local y = physical.y
		local width = physical.width
		local height = physical.height

		self._bump_world:add(physical, x, y, width, height)
		physical:set_bump_world(self._bump_world)	
	end,

	add_visible = function(self, visible)
		insert(self._draw_list, visible)
	end,
	
	add = function(self, object)
		self:add_physical(object)
		self:add_visible(object)
	end,
	
	remove = function(self, physical)
		self._bump_world:remove(physical)
		physical:unset_bump_world(self)	
	end, 

	draw = function(self)
		for _,visible in ipairs(self._draw_list) do
			visible:draw()
		end 
	end
}

return world
