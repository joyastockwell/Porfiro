local pi	= math.pi

local cos	= math.cos
local sin 	= math.sin
local tan	= math.tan

local math_ext	= { }

local function radians_to_degrees(radians)
	return (180 * pi) / radians
end

local function degrees_to_radians(degrees)
	return (degrees * pi) / 180
end

math_ext.sin = function(angle_degrees)
	return sin(degrees_to_radians(angle_degrees)) 
end

math_ext.cos = function(angle_degrees)
	return cos(degrees_to_radians(angle_degrees))
end

math_ext.tan = function(angle_degrees)
	return tan(degrees_to_radians(angle_degrees))
end

math_ext.radians_to_degrees = radians_to_degrees
math_ext.degrees_to_radians = degrees_to_radians

return math_ext
