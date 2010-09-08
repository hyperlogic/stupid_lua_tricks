-- love console

require "vec2"

local gfx = love.graphics

module(..., package.seeall)

local shiftTable = {["`"] = "~", ["1"] = "!", ["2"] = "@", ["3"] = "#", ["4"] = "$",
					["5"] = "%", ["6"] = "^", ["7"] = "&", ["8"] = "*", ["9"] = "(",
					["0"] = ")", ["-"] = "_", ["="] = "+", ["["] = "{", ["]"] = "}",
					[";"] = ":", ["'"] = '"', [","] = "<", ["."] = ">", ["/"] = "?",
					[" "] = " ", ["\\"] = "|" }
function new ()
	return {update = update,
			draw = draw,
			keypressed = keypressed,
			keyreleased = keyreleased,
			alphaKey = alphaKey,
			nonAlphaKey = nonAlphaKey,
			["return"] = returnKey,
			backspace = backspaceKey,
			lines = {""},
			hidden = true,
			currentLine = 1,
			lineHeight = 28,
			max_lines = 25,
			shiftDown = false,
			ctrlDown = false,
			metaDown = false,
			lineLength = 56,
			prompt = "> "}
end

function update (self, dt)
	-- TODO: blinky cursor!
end

local function drawText(self, offset, ...)
	gfx.setColor(...)
	local start = #self.lines > self.max_lines and (#self.lines - self.max_lines) or 1
	local stop = #self.lines

	local n = 1
	for i = start, stop do
		local line = self.lines[i]
		if i == self.currentLine then
			line = self.prompt..self.lines[i]
		end
		gfx.print(line, 0 + offset.x, n * self.lineHeight + offset.y)
		n = n + 1
	end
end

function draw (self)
	if self.hidden then return end

	gfx.setColor(0, 0, 0, 180)
	gfx.rectangle("fill", 0, 0, gfx.getWidth(), gfx.getHeight())

	local dropShadowOffset = vec2.new(2, 2)
	drawText(self, dropShadowOffset, 0, 0, 0, 255)
	drawText(self, vec2.new(0, 0), 255, 255, 255, 255)
end

function keypressed (self, key, unicode)

	if key == "escape" then
		self.hidden = not self.hidden
	end

	if self.hidden then return end

	-- keep track of shift, meta & control button states
	if key == "lshift" or key == "rshift" then
		self.shiftDown = true
		return
	elseif key == "lmeta" or key == "rmeta" then
		self.metaDown = true
		return
	elseif key == "lctrl" or key == "rctrl" then
		self.ctrlDown = true
		return
	end

	-- dispatch to a key handler function
	if key:len() == 1 then
		if key:match("%a") then
			self:alphaKey(key)
		else
			self:nonAlphaKey(key)
		end
	else
		if self[key] then
			self[key](self)
		else
			print("missing handler for ", key)
		end
	end
end

function keyreleased (self, key, unicode)
	if self.hidden then return end
	if key == "rshift" or key == "lshift" then
		self.shiftDown = false
	end
end

function alphaKey(self, key)

	if self.shiftDown then
		key = key:upper()
	end

	-- append key to end of current line
	self.lines[self.currentLine] = self.lines[self.currentLine]..key
end

function nonAlphaKey(self, key)

	if self.shiftDown then
		orig_key = key
		key = shiftTable[key]
		if not key then print(string.format("WARNING: key %s not in shiftTable", orig_key)) end
	end

	-- append key to end of current line
	self.lines[self.currentLine] = self.lines[self.currentLine]..key
end

function returnKey(self)

	-- eval current line
	local orig_line = self.lines[self.currentLine]
	local eval_line = orig_line
	if eval_line:sub(1, 1) == "=" then
		eval_line = "return "..eval_line:sub(2)
	elseif eval_line == "quit" then
		os.exit(1)
	end

	f = loadstring(eval_line)
	local status, result = xpcall(f, debug.traceback)
	if status then
		result = pp.linewrap(pp.val2str(result), self.lineLength)
	else
		result = pp.linewrap("ERROR: "..result, self.lineLength)
	end

	-- prepend the prompt to the current line
	self.lines[self.currentLine] = self.prompt..orig_line
	self.currentLine = self.currentLine + 1
	
	-- append the result
	for line in string.gmatch(result.."\n", "([^\n]+)\n") do
		self.lines[self.currentLine] = line
		self.currentLine = self.currentLine + 1
	end

	-- new line starts off as the empty string
	self.lines[self.currentLine] = ""
	--self.currentLine = self.currentLine + 1
end

function backspaceKey(self)
	-- remove a character from end of current line
	local line = self.lines[self.currentLine]
	self.lines[self.currentLine] = line:sub(1, line:len() - 1)
end
