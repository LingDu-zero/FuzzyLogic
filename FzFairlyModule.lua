local FuzzyTerm = require(script.Parent.FuzzyTermModule)
--local FuzzySet = require(script.Parent.FuzzySet.FuzzySetModule)

local FzFairlyModule = class('FzFairlyModule', FuzzyTerm)

function FzFairlyModule:initialize(fs)
	self._m_Set = fs._m_Set
end

function FzFairlyModule:ClearDOM()
	self._m_Set:ClearDOM()
end

function FzFairlyModule:GetDOM()
	return math.sqrt(self._m_Set:GetDOM())
end

function FzFairlyModule:ORwithDOM(val)
	self._m_Set:ORwithDOM(math.sqrt(val))
end

return FzFairlyModule
