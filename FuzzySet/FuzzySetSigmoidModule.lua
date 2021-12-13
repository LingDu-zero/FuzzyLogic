local FuzzySet = require(script.Parent.FuzzySetModule)

local FuzzySetSigmoidModule = class('FuzzySetSigmoidModule', FuzzySet)

function FuzzySetSigmoidModule:initialize(mid, lft, rgt, k)
	assert(k ~= 0, "Error: In SigmoidSet, k can't be 0!")
	self.m_dPeakPoint = mid
	self.m_dLeftOffset = lft
	self.m_dRightOffset = rgt
	self.m_K = k
	if k > 0 then
		FuzzySet.initialize(self, mid + rgt)
	else
		FuzzySet.initialize(self, mid - lft)
	end
end

function FuzzySetSigmoidModule:CalculateDOM(val)
	if val >= (self.m_dPeakPoint - self.m_dLeftOffset) and val <= (self.m_dPeakPoint + self.m_dRightOffset) then
		return 1/(1 + math.exp(self.m_K*(self.m_dPeakPoint-val)))
	else
		return 0.0
	end
	
end

return FuzzySetSigmoidModule
