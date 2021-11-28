local FuzzySet = require(script.Parent.FuzzySetModule)

local FuzzySetRightShoulderModule = class('FuzzySetRightShoulderModule', FuzzySet)

function FuzzySetRightShoulderModule:initialize(peak, lft, rgt)
	self.m_dPeakPoint = peak
	self.m_dLeftOffset = lft
	self.m_dRightOffset = rgt
	FuzzySet.initialize(self, ((peak + rgt) + peak)/2)
end

function FuzzySetRightShoulderModule:CalculateDOM(val)
	if (self.m_dLeftOffset == 0.0 and val == self.m_dPeakPoint) or (self.m_dRightOffset == 0.0 and val == self.m_dPeakOffset) then
		return 1.0
	end
	if val <= self.m_dPeakPoint and val >= (self.m_dPeakPoint - self.m_dLeftOffset) then
		grad = 1.0/self.m_dLeftOffset
		return grad * (val - (self.m_dPeakPoint - self.m_dLeftOffset))
	elseif val > self.m_dPeakPoint and val <= (self.m_dPeakPoint + self.m_dRightOffset) then
		return 1.0
	else
		return 0.0
	end
	
end

return FuzzySetRightShoulderModule
