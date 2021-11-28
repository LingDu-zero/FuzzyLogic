local FuzzySet = require(script.Parent.FuzzySetModule)

local FuzzySetLeftShoulderModule = class('FuzzySetLeftShoulderModule', FuzzySet)

function FuzzySetLeftShoulderModule:initialize(peak, lft, rgt)
	self.m_dPeakPoint = peak
	self.m_dLeftOffset = lft
	self.m_dRightOffset = rgt
	FuzzySet.initialize(self, ((peak - lft) + peak)/2)
end

function FuzzySetLeftShoulderModule:CalculateDOM(val)
	if (self.m_dLeftOffset == 0.0 and val == self.m_dPeakPoint) or (self.m_dRightOffset == 0.0 and val == self.m_dPeakOffset) then
		return 1.0
	end
	if val < self.m_dPeakPoint and val >= (self.m_dPeakPoint - self.m_dLeftOffset) then
		return 1.0
	elseif val >= self.m_dPeakPoint and val <= (self.m_dPeakPoint + self.m_dRightOffset) then
		grad = 1.0/-self.m_dRightOffset
		return grad * (val - self.m_dPeakPoint) + 1.0
	else
		return 0.0
	end
	
end

return FuzzySetLeftShoulderModule
