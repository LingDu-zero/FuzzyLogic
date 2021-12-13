local FuzzySet = require(script.Parent.FuzzySetModule)

local FuzzySetTrapezoidModule = class('FuzzySetTrapezoidModule', FuzzySet)

function FuzzySetTrapezoidModule:initialize(lftpeak, rgtpeak, lft, rgt)
	self.m_dLeftPeakPoint = lftpeak
	self.m_dRightPeakPoint = rgtpeak
	self.m_dLeftOffset = lft
	self.m_dRightOffset = rgt
	FuzzySet.initialize(self, (lftpeak + rgtpeak)/2)
end

function FuzzySetTrapezoidModule:CalculateDOM(val)
	if (self.m_dLeftOffset == 0.0 or self.m_dRightOffset == 0.0) and (val >= self.m_dLeftPeakPoint and val <= self.m_dRightPeakPoint) then
		return 1.0
	end
	if val < self.m_dLeftPeakPoint and val >= (self.m_dLeftPeakPoint - self.m_dLeftOffset) then
		grad = 1.0/self.m_dLeftOffset
		return grad * (val - (self.m_dLeftPeakPoint - self.m_dLeftOffset))
	elseif val >= self.m_dRightPeakPoint and val <= (self.m_dRightPeakPoint + self.m_dRightOffset) then
		grad = 1.0/-self.m_dRightOffset
		return grad * (val - self.m_dRightPeakPoint) + 1.0
	else
		return 0.0
	end
	
end

return FuzzySetTrapezoidModule
