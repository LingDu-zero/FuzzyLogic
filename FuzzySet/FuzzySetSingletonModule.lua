local FuzzySet = require(script.Parent.FuzzySetModule)

local FuzzySetSingletonModule = class('FuzzySetSingletonModule', FuzzySet)

function FuzzySetSingletonModule:initialize(mid, lft, rgt)
	self.m_dMidPoint = mid
	self.m_dLeftOffset = lft
	self.m_dRightOffset = rgt
	FuzzySet.initialize(self, mid)
end

function FuzzySetSingletonModule:CalculateDOM(val)
	if val >= (self.m_dMidPoint - self.m_dLeftOffset) and val <= (self.m_dMidPoint + self.m_dRightOffset) then
		return 1.0
	else
		return 0.0
	end
	
end

return FuzzySetSingletonModule
