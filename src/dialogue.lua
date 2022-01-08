dialogue = {
	_line_index = 1,
	lines = { },
	position = { 0, 0 }, 
	current_line = function(self) 	
		return self.lines[self._line_index]
	end,
	update_position = function(self) 
		local y = floor.y + (floor.height / 2)
	
		local cur_line = self.lines[self._line_index]
		local line_width = cur_line:getWidth()
		local x = (WORLD_WIDTH - line_width) / 2	

		self.position[1] = x
		self.position[2] = y 
	end
}

--elseif love.keyboard.isDown("space") then
--	if key_space_cooldown <= 0 then
--		if dialogue._line_index < #dialogue.lines then
--			dialogue._line_index = dialogue._line_index + 1
--			dialogue:update_position()
--			--print("x", dialogue.position.x)
--			--print("y", dialogue.position.y)
--		end
--		key_space_cooldown = key_space_cooldown + KEYPRESS_DELAY
--	end
--end

