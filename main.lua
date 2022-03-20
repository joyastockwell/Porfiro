package.path = package.path .. ";./src/?.lua"

local format 		= string.format
local insert		= table.insert
local open		= io.open

local new_text  	= love.graphics.newText
local new_sound_source 	= love.audio.newSource

local actor 		= require("actor")
local  Actor		=  actor.Actor
local  RIGHT_HEADING	=  actor.RIGHT_HEADING
local  LEFT_HEADING	=  actor.LEFT_HEADING

local menu		= require("menu")
local  Button		=  menu.Button
local  Cursor		=  menu.Cursor

local physical		= require("physical")
local  Block		=  physical.Block
local  VerticalBound	=  physical.VerticalBound

local visible 		= require("visible")
local  COLOR_BLACK	= visible.COLOR_BLACK
local  COLOR_BLUE	= visible.COLOR_BLUE
local  COLOR_RED	= visible.COLOR_RED
local  COLOR_WHITE	= visible.COLOR_WHITE
local  Trapezoid	= visible.IsocelesTrapezoid
local  Rectangle	= visible.Rectangle

local world 		= require("world")
local  World		=  world.World

--[[ Constants ]]
local WORLD_WIDTH  = 1000
local WORLD_HEIGHT = 750
local GRAVITY 	   = 300 

local CORNELIA_DX_DT = 5
local CORNELIA_JUMP = -150 

--[[ Globals ]]
local world
local cornelia
local cursor

local cornelia_l = "assets/cornelia_left.png"
local cornelia_r = "assets/cornelia.png"

local music = new_sound_source("assets/start_menu.mp3", "stream")

function love.load()
	local function setup_window()
		love.window.setMode(1000, 750)
	end

	local function setup_sound()
		music:play()
	end

	local function setup_graphics()
		love.graphics.setBackgroundColor(unpack(COLOR_WHITE))
		--love.mouse.setVisible(false)

		trap = Trapezoid(400, 300, 100, 100, COLOR_RED)
	end

	local function setup_dialogue()
	end

	local function setup_physics()
		world = World()

		cornelia = Actor(1, 0, cornelia_l, cornelia_r)
		world:add(cornelia)

		local floor = Block({
			x = 0,
			y = 650,
			width = WORLD_WIDTH,
			height = 100,
			color = COLOR_BLACK,
		})

		world:add(floor)

		local left_bound = VerticalBound(0, 0, WORLD_HEIGHT)
		world:add_physical(left_bound)
	
		local right_bound = VerticalBound(WORLD_WIDTH, 0, WORLD_HEIGHT)
		world:add_physical(right_bound)

		-- Menu
		local button = Button({
			x = 500,
			y = 375,
			x_margin = 10,
			y_margin = 10,
			x_curve = 0.2,
			y_curve = 0.2,
			text = "Hello, world",
			font = {
				filename = "assets/fonts/FreeSans.otf",
				size = 18
			},
			action = function() print("Hello, world!") end,
			color = COLOR_RED
		})
		world:add(button)

		cursor = Cursor("assets/cursor.png", 0, 0)
		world:add(cursor)

	end
	
	local function setup_events()
		love.mousepressed = function(x, y, button)
			cursor:handle_mouse_press(button)
		end
	end

	setup_window()
	--setup_sound()
	setup_graphics()
	--setup_physics()
	setup_events()
end

local KEYPRESS_DELAY = 0.5
local key_w_cooldown 	 = 0  
local key_space_cooldown = 0 

local function handle_player_input(dt)
	local cornelia_x = 0 
	local cornelia_y = 0

	if key_w_cooldown > 0 then
		key_w_cooldown = key_w_cooldown - dt
	end

	if key_space_cooldown > 0 then
		key_space_cooldown = key_space_cooldown - dt
	end

	if love.keyboard.isDown("w") then
		if key_w_cooldown <= 0 then
			cornelia_y = cornelia_y + CORNELIA_JUMP
			key_w_cooldown = key_w_cooldown + KEYPRESS_DELAY
		end
	elseif love.keyboard.isDown("a") then
		cornelia:set_heading(LEFT_HEADING)
		cornelia_x = cornelia_x - CORNELIA_DX_DT
	elseif love.keyboard.isDown("d") then
		cornelia:set_heading(RIGHT_HEADING)
		cornelia_x = cornelia_x + CORNELIA_DX_DT
	end

	cornelia_y = cornelia_y + (GRAVITY * dt) 
	cornelia:move(cornelia_x, cornelia_y)
end

function love.update(dt)
	--handle_player_input(dt)	
	--cursor:update_position()
end

function love.draw()
	--world:draw()
	trap:draw()
end
