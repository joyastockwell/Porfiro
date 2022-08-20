local class 		= require("useful.class")
local  Class		=  class.Class

local physical		= require("physical")
local  Block		=  physical.Block
local  VerticalBound	=  physical.VerticalBound
local  Aura				=  physical.Aura

local draw_rect		= love.graphics.rectangle

local jonny1 = {}

jonny1.Jonny1 = Class(Visible, Physical, {

    new = function(self, porfiro1, x, y)
        self.porfiro1 = porfiro1
		self.x = x
		self.y = y
        self.width = 42
        self.height = 84
        self.jonny1_aura = new_Aura(self.x, self.y, self.width, self.height)
	end,

    draw = function(self)
        --just drawing Jonny as a rectangle for now
		draw_rect("fill", self.x, self.y, self.width, self.height, 0, 0)
	end,

    is_in_jonny1s_aura  = function(self, x, y)
        --not sure how collisions will work :/
        if x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height then
            return true
        end
        return false
    end,

    toggle_porfiro1 = function(self)
        self.porfiro1.has_interacted_with_jonny1 = true
    end

})