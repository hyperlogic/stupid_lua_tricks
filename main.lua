-- slide/presentation --

require("vec2")
Console = require("console")
pp = require("prettyprint")
gfx = love.graphics
aud = love.audio

-- globals
t = 0
scale = 1
pos = vec2.new(0, 0)
slides = nil
console = nil
fonts = nil
images = nil
currentSlide = 1

function metatable_demo()
	echo = {}
	setmetatable(echo, {__index = function (self, key)
									  return key
								  end})
	print(echo.hello)   --> "hello"

	malcovitch = {}
	setmetatable(malcovitch, {__index = function ()
											return "malcovitch"
										end})
	print(malcovitch["something"])
	print(malcovitch.malchvitch)

	-- prototype poem
	poem = {roses = "red", violets = "blue"}

	-- rhyming poem
	rhyme = {violets = "dead"}
	mt = {__index = poem}
	setmetatable(rhyme, mt)

	print("roses are "..rhyme["roses"])
	print("violets are "..rhyme["violets"])


	-- clone example.
	local function clone(orig, diff)
		setmetatable(diff, {__index = orig})
		return diff
	end

	burger = {meat = true,
			  mustard = true,
			  catsup = true,
			  pickle = true}
	
	-- BACON! Hold the mustard
	special = clone(burger, {bacon = true, mustard = false})

end

-- returns all of the slides from the slides.lua file
function loadSlides ()
	local slides = {}

	-- init Slide function
	local slideDefaults = {lines = {}, quads = {}}
	Slide = function (slide)
				setmetatable(slide, {__index = slideDefaults})
				table.insert(slides, slide)
			end

	-- init Line function
	local lineDefaults = {text = "default", align = "center", font = "small",
						  color = {255,255,255,255}, pos = vec2.new(0, 200)}
	Line = function (line)
			   setmetatable(line, {__index = lineDefaults})
			   return line
		   end

	-- init Quad function
	local quadDefaults = {image = "default", 
						  quad = gfx.newQuad(0,0,1,1,1,1),
						  color = {255,255,255,255}, 
						  pos = vec2.new(0, 0),
						  size = vec2.new(200,200)}
	Quad = function (quad)
			   setmetatable(quad, {__index = quadDefaults})
			   return quad
		   end

	dofile("slides.lua")
	Slide = nil
	Line = nil
	Quad = nil
	return slides
end

-- draws a single slide
function drawSlide (slide)
	-- draw quads
	for i, quad in ipairs(slide.quads) do
		gfx.setColor(unpack(quad.color))
		gfx.drawq(images[quad.image], quad.quad, quad.pos.x, quad.pos.y, 0,
				  quad.size.x, quad.size.y)
	end

	-- draw black dropshadow text
	gfx.push()
	gfx.translate(2, 2)
	for i, line in ipairs(slide.lines) do
		gfx.setFont(fonts[line.font])
		gfx.setColor(0,0,0,255)
		gfx.printf(line.text, line.pos.x, line.pos.y, gfx.getWidth(), line.align)
	end
	gfx.pop()

	for i, line in ipairs(slide.lines) do
		gfx.setFont(fonts[line.font])
		gfx.setColor(unpack(line.color))
		gfx.printf(line.text, line.pos.x, line.pos.y, gfx.getWidth(), line.align)
	end
end

function love.load ()
	console = Console.new()

	fonts = {large = gfx.newFont("prstartk.ttf", 50),
			 small = gfx.newFont("prstartk.ttf", 35),
			 console = gfx.newFont("Bitstream-Vera-Sans-Mono.ttf", 30),
			 codesmall = gfx.newFont("Bitstream-Vera-Sans-Mono.ttf", 20),
			 codemedium = gfx.newFont("Bitstream-Vera-Sans-Mono.ttf", 30),
		     code = gfx.newFont("Bitstream-Vera-Sans-Mono.ttf", 40)}

	images = {lua = gfx.newImage("lua.gif"),
		      brazil = gfx.newImage("brazil.jpg"),
		      numbers = gfx.newImage("numbers.jpg"),
		      happy_kitty = gfx.newImage("happy_kitty.jpg"),
		      table = gfx.newImage("table.jpg"),
		      turducken = gfx.newImage("turducken.jpg"),
		      sadkeanu = gfx.newImage("sadkeanutitle.jpg"),
			  malkovich = gfx.newImage("malkovich.jpg"),}

	sounds = {}
	for i = 1, 9 do
		table.insert(sounds, aud.newSource("powerup0"..i..".ogg", "static"))
	end

	slides = loadSlides()

	-- for debugging look at the last slide
	--currentSlide = #slides

	metatable_demo()
end

function love.draw ()
	gfx.setBackgroundColor(80, 80, 150)

	gfx.push()
	gfx.translate(pos.x, pos.y)
	gfx.scale(scale, scale)

	drawSlide(slides[currentSlide])

	if slides[currentSlide].draw then
		slides[currentSlide].draw(slides[currentSlide])
	end

	gfx.pop()
	gfx.setFont(fonts.console)
	console:draw()
end

function love.update (dt)
	t = t + dt
	console:update(dt)

	-- use the left stick to scale the camera
	local scale_speed = 0.3
	local axis = love.joystick.getAxis(0, 1)
	if math.abs(axis) > 0.2 then
		scale = scale + scale_speed * axis * dt
	end

	-- use right stick to translate the camera
	local trans_speed = 50.0
	local leftStick = vec2.new(love.joystick.getAxis(0, 2), love.joystick.getAxis(0, 3))
	if leftStick:len() > 0.2 then
		pos = pos + leftStick * (dt * trans_speed)
	end
end

function love.keypressed (key, unicode)

	if slides[currentSlide].keypressed then
		slides[currentSlide].keypressed(slides[currentSlide], key, unicode)
	end

	if key == "right" then
		next_slide()
	elseif key == "left" then
		prev_slide()
	end

	console:keypressed(key, unicode)
end

function love.keyreleased (key, unicode)
	console:keyreleased(key, unicode)
end

function love.joystickpressed (joystick, button)

	if slides[currentSlide].joystickpressed then
		slides[currentSlide].joystickpressed(slides[currentSlide], joystick, button)
	end

	-- x: next slide
	if button == 11 then
		next_slide()
	end

	-- b: prev slide
	if button == 12 then
		prev_slide()
	end
end

function next_slide ()
	currentSlide = currentSlide + 1
	if currentSlide > #slides then
		currentSlide = #slides
	end
	play_goofy_sound()
end

function prev_slide ()
	currentSlide = currentSlide - 1
	if currentSlide < 1 then
		currentSlide = 1
	end
	play_goofy_sound()
end

function play_goofy_sound ()
	-- TODO: make random
	aud.play(sounds[((currentSlide - 1) % #sounds) + 1])
end