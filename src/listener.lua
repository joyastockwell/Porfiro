local insert = table.insert

local class	= require("useful.class")
local  Class	=  class.Class

local listener = { }

listener.Listener = Class { 
    
	subscribe = function(handler, event_list) 
    end,

    lis = function()
    end

}


listener.AuraListener = Class(listener.Listener, {
	new = function(self)
        self.subscribers_by_event = {}
	end,

    subscribe = function(handler, event_list)
        for event in ipairs(event_list) do
            insert(self.subscribers_by_event[event],handler)
        end
    end,

    lis = function(self)
        i = love.event.poll()
        if love.event then
            love.event.pump()
            for name in love.event.poll() do 
                if name ~= "quit" then
                    print("meep")
                    print(name)
                end
            end
        end
        -- print(love.event)
        -- print(love.event.pump())
        -- for n in love.event.poll() do 
        --     if n == "keypressed" then
        --         print("moop")
        --         -- if a =="w" then
        --         --     print("w was pressed")
        --         -- end
        --     end
        -- end
    end    


})

return listener


    -- self.x = get_mouse_x()
    -- self.y = get_mouse_y()

    -- local _,_, cols = self._world:move(self, self.x, self.y, collide)

    -- -- Flag all items that appear in the "collision" (i.e. 
    -- -- objects the mouse is hovering over. The boolean value
    -- -- is meaningless here and used only for
    -- -- flagging purposes
    -- for _, col in ipairs(cols) do
    --     self._hover_overs[col.other] = false
    -- end

    -- -- Unflagged entries are not currently being hovered
    -- -- over, so we remove them from the list of ones that
    -- -- are. Also reset the flagged values so they exhibit
    -- -- proper behavior during the next collision check 
    -- for object, flag in pairs(self._hover_overs) do
    --     if flag == true then
    --         self._hover_overs[object] = nil		
    --         if object.type() == "button" then
    --             object:on_hover_leave()	
    --         end
    --     else
    --         self._hover_overs[object] = true
    --     end
    -- end
    -- end,

    -- handle_mouse_press = function(self, button)
    -- if button == 1 then
    --     for object,_ in pairs(self._hover_overs) do
    --         object:on_primary_click()
    --     end
    -- elseif button == 2 then
    --     for object,_ in pairs(self._hover_overs) do
    --         object:on_secondary_click()
    --     end

    -- elseif button == 3 then
    --     for object,_ in pairs(self._hover_overs) do
    --         object:on_tertiary_click()
    --     end

    -- end		
    -- end,

    -- draw = function(self)
    -- love_draw(self._image, self.x, self.y)
    -- end