-- slides data file

local width = gfx.getWidth()
local height = gfx.getHeight()
local white = {255, 255, 255, 255}
local vlightblue = {255, 255, 255, 255}
local lightblue = {140, 140, 255, 255}
local medblue = {80, 80, 255, 255}
local green = {30, 255, 30, 255}
local lightgray = {180, 180, 180, 255}
local gray = {120, 120, 120, 255}
temp_quad = gfx.newQuad(0,0,1,1,1,1)

-- intro slide
Slide {
	lines = { 
		Line { text = "Stupid LUA Tricks!", 
			   font = "large",
			   pos = vec2.new(0, 120) }, 
		Line { text = "Abusing Tables for Fun and Profit!",
			   pos = vec2.new(0, 650) } 
	},
	quads = { 
		Quad { image = "lua",
			   pos = vec2.new(width/2 - 200, height/2 - 200),
			   size = vec2.new(400, 400) }
	}
}

-- Overview
Slide {
	lines = { 
		Line { text = "Language Goals",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* App Extention Language",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Designed to be Embedded",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* Mechanism not Policy",
			   pos = vec2.new(100, 500),
		       align = "left" },
	}
}

-- GOALL
Slide {
	lines = { 
		Line { text = "From Brazil!",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "GOOOAAAALLL!",
			   color = green,
			   font = "large",
			   pos = vec2.new(0, 300) },
	},
	quads = {
		Quad { image = "brazil",
			   pos = vec2.new(width/2 - 200, height/2 - 300),
			   size = vec2.new(400, 600) }
	}
}

-- Features
Slide {
	lines = { 
		Line { text = "It's Dyno-mite",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* Dynamic Language",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Interpreted",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* Garbage Collected",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* Easily Extendible",
			   pos = vec2.new(100, 600),
		       align = "left" },
	}
}

-- More
Slide {
	lines = { 
		Line { text = "Computer Science!",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* First Class Functions",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Co-Routines",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* Lexically Scoped",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* Dynamic Environment",
			   pos = vec2.new(100, 600),
		       align = "left" },
	}
}

-- More
Slide {
	lines = { 
		Line { text = "It's Tiny",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* Minimal Core",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Optional Standard Libs",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* Batteries NOT Included",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* 17,000 lines of C",
			   pos = vec2.new(100, 500),
		       align = "left" },
	}
}

-- A Taste of Lua
-- if statement
Slide {
	lines = { 
		Line { text = "A Taste of Lua",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = 
"-- comment\
if value < 2 then\
    print(\"small\")\
elseif value < 10 then\
    print(\"medium\")\
else\
    print(\"big\")\
end",
			   pos = vec2.new(200, 200),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Plottin' some Points
-- numeric for loop
Slide {
	lines = { 
		Line { text = "Plottin' some Points",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
-- draw sine wave\
for i = 1, 1024, 10 do\
    local y = (150 * math.sin(i/100 + t)) + 300\
    love.graphics.point(i, y)\
end",
			   pos = vec2.new(100, 200),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	},
	eval_text = false,
	draw = function (self)
			   if self.eval_text then
				   -- fat points
				   love.graphics.setPointStyle("smooth")
				   love.graphics.setPointSize(3)
				   love.graphics.setColor(255, 255, 255, 255)
				   f = loadstring(self.lines[2].text)
				   f()
			   end
		   end,
	joystickpressed = function (self, joystick, button)
						  -- y button
						  if button == 14 then
							  self.eval_text = not self.eval_text
							  play_goofy_sound()
						  end
					  end,
	keypressed = function (self, key, unicode)
					 if key == "up" then
						 self.eval_text = not self.eval_text
						 play_goofy_sound()
					 end
				 end
}

-- The count!
Slide {
	lines = { 
		Line { text = "Numbers!",
			   color = lightgray,
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "Von, Two, Three",
			   font = "large",
			   color = gray,
			   pos = vec2.new(0, 600) },
		Line { text = "AH AH AH!",
			   font = "large",
			   color = lightgray,
			   pos = vec2.new(0, 700) },
	},
	quads = {
		Quad { image = "numbers",
			   pos = vec2.new(width/2 - 300, height/2 - 300),
			   size = vec2.new(600, 600) }
	}
}

-- Numbers
Slide {
	lines = { 
		Line { text = "Numbers",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* Double Precision Floats",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Used as Indices",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* No Rounding Problems",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* As Fast as Ints",
			   pos = vec2.new(100, 600),
		       align = "left" },
	}
}

-- Strings
Slide {
	lines = { 
		Line { text = "Strings",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* Immutable",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* .. Operator",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* # Operator",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* String Library",
			   pos = vec2.new(100, 600),
		       align = "left" },
	}
}

-- String
Slide {
	lines = { 
		Line { text = "Catin' some Strings",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
local prefix = \"You May Have\"\
local suffix = \"Already Won\"\
gfx.print(prefix..\" \"..suffix, 100, 600)\
gfx.setColor(255, 0, 0, 255)\
local d = \"$\"..string.format(\"%d\", t * 1000)\
gfx.print(d, 400, 650)\
",
			   pos = vec2.new(100, 200),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	},
	
	eval_text = false,
	draw = function (self)
			   if self.eval_text then
				   local pos = vec2.new(width/2 - 200 + (200 * math.sin(t/1)), height/2 - 200)
				   local size = vec2.new(400, 340)
				   gfx.drawq(images["happy_kitty"], temp_quad, pos.x, pos.y, 0, size.x, size.y)
				   gfx.setFont(fonts["small"])
				   gfx.setColor(255, 255, 255, 255)
				   f = loadstring(self.lines[2].text)
				   f()
			   end
		   end,
	joystickpressed = function (self, joystick, button)
						  -- y button
						  if button == 14 then
							  self.eval_text = not self.eval_text
							  play_goofy_sound()
						  end
					  end,
	keypressed = function (self, key, unicode)
					 if key == "up" then
						 self.eval_text = not self.eval_text
						 play_goofy_sound()
					 end
				 end
}

-- Nil, Booleans and You
Slide {
	lines = { 
		Line { text = "Nil, Booleans and You",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* nil is a value",
			   pos = vec2.new(50, 300),
		       align = "left" },
		Line { text = "* true and false are values",
			   pos = vec2.new(50, 400),
		       align = "left" },
		Line { text = "* nil and false are false",
			   pos = vec2.new(50, 500),
		       align = "left" },
		Line { text = "* everything else is true",
			   pos = vec2.new(50, 600),
		       align = "left" },
	}
}

-- Nil Guard #1
Slide {
	lines = { 
		Line { text = "Nil Guards",
			   pos = vec2.new(0, 100),
			   font = "large" },

		Line { text = 
"-- if value is nil\
if not value then\
    value = \"something\"\
end\
manipulate(value)\
",
			   pos = vec2.new(200, 250),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Nil Guard #2
Slide {
	lines = { 
		Line { text = "Nil Guards",
			   pos = vec2.new(0, 100),
			   font = "large" },

		Line { text = 
"-- nil guard\
value = value or \"something\"\
manipulate(value)\
",
			   pos = vec2.new(200, 300),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Conditional Operator
Slide {
	lines = { 
		Line { text = "Conditional Assignment",
			   pos = vec2.new(0, 100),
			   font = "large" },

		Line { text = 
"-- tedious\
local greeting\
if arriving() then\
    greeting = \"hello\"\
else\
    greeting = \"goodbye\"\
end",
			   pos = vec2.new(200, 300),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Conditional Operator
Slide {
	lines = { 
		Line { text = "Conjunction Junction",
			   pos = vec2.new(0, 100),
			   font = "large" },

		Line { text = 
"-- one liner!\
local greeting = arriving() and \"hello\" or \"goodbye\"\
",
			   pos = vec2.new(50, 400),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	}
}

-- The Usual suspects
Slide {
	lines = { 
		Line { text = "Expressions",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* Relational Operators",
			   pos = vec2.new(50, 300),
		       align = "left" },
		Line { text = "< > <= >= == ~=",
			   font = "code",
			   pos = vec2.new(50, 400),
		       align = "center" },
		Line { text = "* Arithmetic Operators",
			   pos = vec2.new(50, 500),
		       align = "left" },
		Line { text = "+ - * ^ %",
			   font = "code",
			   pos = vec2.new(50, 600),
		       align = "center" },
	}
}


-- TABLES
Slide {
	lines = { 
		Line { text = "Tables!",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "The Universal Data Structure",
			   pos = vec2.new(0, 700),
			   font = "small" },
	},
	quads = {
		Quad { image = "table",
			   pos = vec2.new(width/2 - 300, height/2 - 200),
			   size = vec2.new(600, 400) }
	}
}

-- Tables as Arrays
Slide {
	lines = { 
		Line { text = "Tables as Arrays",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
days = {\"Sunday\", \"Monday\", \"Tuesday\", \
        \"Wednesday\", \"Thursday\",\
        \"Friday\", \"Saturday\"}\
\
-- OMG! indices start at 1\
print(days[1]..\" thru \"..days[#days])\
\
#=> Sunday thru Saturday\
",
			   pos = vec2.new(50, 200),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Iterating Arrays
Slide {
	lines = { 
		Line { text = "Iterating Arrays",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
-- ipairs returns an iterator\
for i, day in ipairs(days) do\
    print(day..\" is day #\"..i)\
end\
",
			   pos = vec2.new(140, 240),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Tables as Hash tables
Slide {
	lines = { 
		Line { text = "Hash Tables",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
-- keys are strings\
translate = {Sunday = \"Domingo\",\
             Monday = \"Segunda-feira\",\
             Tuesday = \"Terca-feira\",\
             Wednesday = \"Quarta-feira\",\
             Thursday = \"Quinta-feira\",\
             Friday = \"Sexta-feira\",\
             Saturday = \"Sabado\"}\
\
",
			   pos = vec2.new(50, 200),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Lookup in a table
Slide {
	lines = { 
		Line { text = "Hash Tables",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
-- look up by string key\
print(\"I love to sleep on \"..\
      translate[\"Sunday\"])\
\
-- Can also use dot notation\
print(\"I hate \"..translate.Monday)\
\
",
			   pos = vec2.new(50, 200),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Stick anything in a hash.
Slide {
	lines = { 
		Line { text = "Hash Tables",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
-- general hash notation\
grab_bag = {\
  [3] = \"three\",\
  [\"with spaces\"] = {1, 2, 3},\
  turducken = {\
    turkey = {\
      duck = {\
        hen = \"bacon!\"}}}}\
",
			   pos = vec2.new(50, 200),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Turducken
Slide {
	lines = { 
		Line { text = "TURDUCKEN!!",
			   pos = vec2.new(0, 100),
			   font = "large" },
	},
	quads = {
		Quad { image = "turducken",
			   pos = vec2.new(width/2 - 400, height/2 - 400),
			   size = vec2.new(800, 800) }
	}
}

-- Iterating Hashes
Slide {
	lines = { 
		Line { text = "Iterating Hashes",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "\
-- pairs returns an iterator\
for k, v in pairs(translate) do\
    print(k..\" in portuguese is \"..v)\
end\
",
			   pos = vec2.new(50, 240),
			   font = "code",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Tables as Data format
Slide {
	lines = { 
		Line { text = "I Haz Ur Data",
			   pos = vec2.new(0, 70),
			   font = "large" },
		Line { text = "\
Slide {\
  lines = { \
    Line { text = \"Stupid LUA Tricks!\", \
           font = \"\large\",\
           pos = {x = 0, y = 120} },\
    Line { text = \"Abusing Tables for Fun and Profit!\",\
           pos = {x = 0, y = 650} } \
  },\
  quads = { \
    Quad { image = \"lua\",\
           pos = {x = width/2-200, y = height/2-200},\
           size = {x = 400, y = 400} }\
  }\
}\
",
			   pos = vec2.new(30, 150),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	}
}


-- Loading the Data format
Slide {
	lines = { 
		Line { text = "I Loadz it Fur U",
			   pos = vec2.new(0, 70),
			   font = "large" },
		Line { text = "\
function loadSlides (filename)\
    local slides = {}\
    Slide = function (s)\
                table.insert(slides, s)\
            end\
    Line = function (l) return l end\
    Quad = function (q) return q end\
\
    dofile(filename)\
\
    Slide, Line, Quad = nil, nil, nil\
    return slides\
end\
",
			   pos = vec2.new(150, 170),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Sad Keanu
Slide {
	lines = { 
		Line { text = "Lets Get Meta!",
			   color = lightgray,
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "Whoa..",
			   font = "large",
			   pos = vec2.new(50, 700) },
	},
	quads = {
		Quad { image = "sadkeanu",
			   pos = vec2.new(width/2 - 500, height/2 - 250),
			   size = vec2.new(1000, 500) }
	}
}

-- Meta Tables
Slide {
	lines = { 
		Line { text = "Meta Tables",
			   pos = vec2.new(0, 70),
			   font = "large" },
		Line { text = "* Any Table Can Have One",
			   pos = vec2.new(100, 200),
		       align = "left" },
		Line { text = "* __index",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* __newindex",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* Operator Overloading",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* Finalizers",
			   pos = vec2.new(100, 600),
		       align = "left" },
	}
}

-- Malkovich
Slide {
	lines = { 
		Line { text = "Malkovich",
			   pos = vec2.new(0, 100),
			   font = "large" },
        Line { text = "\
t = {}\
setmetatable(t, {__index = function ()\
                               return \"malkovich\"\
                           end})\
print(t[3])\
print(t.malkovich)\
\
#=> malkovich\
#=> malkovich\
",
			   pos = vec2.new(50, 200),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	}
}

-- MALCOVICH
Slide {
	lines = { 
		Line { text = "Malkovich",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* Malkovich",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Malkovich",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "* Malkovich",
			   pos = vec2.new(100, 500),
		       align = "left" },
		Line { text = "* Malkovich",
			   pos = vec2.new(100, 600),
		       align = "left" },
	},
	quads = {
		Quad { image = "malkovich",
			   pos = vec2.new(width/2 - 250, height/2 - 300),
			   size = vec2.new(500, 600) }
	}
}

-- Flowers
Slide {
	lines = { 
		Line { text = "I Prefer Tulips",
			   pos = vec2.new(0, 100),
			   font = "large" },
        Line { text = "\
-- prototype poem\
poem = {roses = \"red\", violets = \"blue\"}\
\
-- rhyming poem\
rhyme = {violets = \"dead\"}\
setmetatable(rhyme, {__index = poem})\
\
print(\"roses are \"..rhyme.roses)\
print(\"violets are \"..rhyme.violets)\
\
> roses are red\
> violets are dead\
",
			   pos = vec2.new(130, 160),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	}
}

-- CLONE
Slide {
	lines = { 
		Line { text = "Have it Your Way",
			   pos = vec2.new(0, 100),
			   font = "large" },
        Line { text = "\
local function clone(orig, diff)\
    setmetatable(diff, {__index = orig})\
    return diff\
end\
\
burger = {meat = true,\
          mustard = true,\
          catsup = true,\
          pickle = true}\
\
-- BACON! Hold the mustard\
special = clone(burger, {bacon = true, \
                         mustard = false})\
",
			   pos = vec2.new(100, 160),
			   font = "codemedium",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Loading the Data format
Slide {
	lines = { 
		Line { text = "Load with Defaults",
			   pos = vec2.new(0, 70),
			   font = "large" },
		Line { text = "\
function loadSlides (filename)\
    local slides = {}\
    local slideDefaults = {lines = {}, quads = {}}\
    Slide = function (s)\
                setmetatable(s, {__index = slideDefaults})\
                table.insert(slides, s)\
            end\
    local lineDefaults = {text = \"\", align = \"center\", font = \"small\",\
                          color = {255,255,255,255}, pos = { x = 0, y = 200}}\
    Line = function (l) \
               setmetatable(l, {__index = lineDefaults})\
               return l \
           end\
    local quadDefaults = {image = \"default\", \
                          color = {255,255,255,255}, \
                          pos = {x = 0, y = 0}, \
                          size = {x = 200, y = 200}}\
    Quad = function (q) \
               setmetatable(q, {__index = quadDefaults})\
               return q \
           end\
\
    dofile(filename)\
\
    Slide, Line, Quad = nil, nil, nil\
    return slides\
end\
",
			   pos = vec2.new(30, 80),
			   font = "codesmall",
			   color = vlightblue,
		       align = "left" },
	}
}

-- Do it your self object orientation.
Slide {
	lines = { 
		Line { text = "Objects",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* D.I.Y. O.O.P.",
			   pos = vec2.new(100, 200),
		       align = "left" },
		Line { text = "* Metatable Chains",
			   pos = vec2.new(100, 300),
		       align = "left" },
		Line { text = "* Syntax Sugar",
			   pos = vec2.new(100, 400),
		       align = "left" },
		Line { text = "obj.method(obj, a, b)\nobj:method(a, b)",
			   pos = vec2.new(100, 500),
			   align = "left",
			   font = "code" },
	},
}

-- Do it your self object orientation.
Slide {
	lines = { 
		Line { text = "Other Cool Stuff",
			   pos = vec2.new(0, 100),
			   font = "large" },
		Line { text = "* LOVE",
			   pos = vec2.new(300, 250),
		       align = "left" },
		Line { text = "* REPL",
			   pos = vec2.new(300, 350),
		       align = "left" },
		Line { text = "* ROCKS",
			   pos = vec2.new(300, 450),
		       align = "left" },
		Line { text = "* WOW UI",
			   pos = vec2.new(300, 550),
		       align = "left" },
		Line { text = "http://www.github.org/hyperlogic/stupid_lua_tricks",
			   pos = vec2.new(0, 650),
			   font = "codemedium" },
	},
}
