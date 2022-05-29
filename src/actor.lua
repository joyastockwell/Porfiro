local class 	= require("useful.class")
local  Class	=  class.Class

local love_draw	= love.graphics.draw
local new_image	= love.graphics.newImage

local physical	= require("physical")
local  Physical	=  physical.Physical

local visible 	= require("visible")
local  Visible	=  visible.Visible 
local  Image	=  visible.Image

local actor = { }

actor.RIGHT_HEADING	= 0
actor.LEFT_HEADING	= 1

actor.Actor = Class(Visible, Physical, {
	new = function(self, x, y, l_image, r_image, heading)
		self.x = x
		self.y = y

		self._left_image = new_image(l_image) 
		self._right_image = new_image(r_image)

		self.width = self._left_image:getWidth()
		self.height = self._left_image:getHeight()

		self.heading = heading or actor.RIGHT_HEADING
	end,

	set_heading = function(self, heading)
		if heading ~= actor.RIGHT_HEADING and 
		   heading ~= actor.LEFT_HEADING then
			error("Invalid heading")
		end

		self.heading = heading
	end, 

	set_position = function(self, x, y)
		self.x = x 
		self.y = y
	end,

	move = function(self, dx, dy)
		local function collide(actor, other)
			if other.type() == "cursor" then
				return "cross"
			end

			return "slide"
		end

		local x = self.x + dx
		local y = self.y + dy

		x, y, collisions = self._bump_world:move(self, x, y, collide)
		
		self.x = x
		self.y = y
	end,

	draw = function(self)
		if self.heading == actor.RIGHT_HEADING then
			love_draw(self._right_image, self.x, self.y)
		else
			love_draw(self._left_image, self.x, self.y)
		end	
	end
})

return actor
