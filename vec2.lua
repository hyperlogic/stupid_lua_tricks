local setmetatable = setmetatable

local sqrt = math.sqrt
local type = type

module(...)

function add (a, b)
   return new(a.x + b.x, a.y + b.y)
end

function sub (a, b)
   return new(a.x - b.x, a.y - b.y)
end

function unm (a)
   return new(-a.x, -a.y)
end

function mul (a, b)
   if type(b) == "number" then
	  return new(a.x * b, a.y * b)
   else
	  return new(a.x * b.x, a.y * b.y)
   end
end

function div (a, b)
   if type(b) == "number" then
	  return new(a.x / b, a.y / b)
   else
	  return new(a.x / b.x, a.y / b.y)
   end
end

methods = {}

function methods.len (self)
   return sqrt(self.x * self.x + self.y * self.y)
end

function methods.unit (self)
   return self / self:len()
end

function new (x, y)
   v = {x = x, y = y, len = len, unit = unit}
   setmetatable(v, mt)
   return v
end

mt = {}
mt.__add = add
mt.__sub = sub
mt.__unm = unm
mt.__mul = mul
mt.__div = div
mt.__index = methods
