local class 	= require("useful.class")
local  Class	=  class.Class

local system = { }

system.EventHandler = Class {
	new = function(self)
		self._key_press_callbacks = { }
		self._mouse_press_callbacks = { }

		love.keypressed = function(key, scancode, is_repeat)
			handler:on_key_press(key, scancode, is_repeat)
		end

		love.mousepressed = function(x, y, button, is_touch)
			handler:on_mouse_press(x, y, button, is_touch)
		end
	end,
		
	on_key_press = function(self, key, scancode, is_repeat)
		local callback = self._key_press_callback[key]

		if callback ~= nil then
			callback()
		end
	end,

	on_mouse_press = function(self, x, y, button, is_touch)
		local callback = self._mouse_press_callback[key]
		
		if callback ~= nil then
			callback()
		end
	end,

	register_key_press_callback = function(self, keycode, callback)
}

return system
