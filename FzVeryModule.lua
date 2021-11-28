local FuzzyTerm = require(script.Parent.FuzzyTermModule)
--local FuzzySet = require(script.Parent.FuzzySet.FuzzySetModule)

local FzVeryModule = class('FzVeryModule', FuzzyTerm)

function FzVeryModule:initialize(fs)
	self._m_Set = fs._m_Set
end

function FzVeryModule:ClearDOM()
	self._m_Set:ClearDOM()
end

function FzVeryModule:GetDOM()
	return self._m_Set:GetDOM()*self._m_Set:GetDOM()
end

function FzVeryModule:ORwithDOM(val)
	self._m_Set:ORwithDOM(val*val)
end

return FzVeryModule
