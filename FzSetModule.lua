local FuzzyTerm = require(script.Parent.FuzzyTermModule)
--local FuzzySet = require(script.Parent.FuzzySet.FuzzySetModule)

local FzSetModule = class('FzSetModule', FuzzyTerm)

function FzSetModule:initialize(fs)
	self._m_Set = fs
end

function FzSetModule:ClearDOM()
	self._m_Set:ClearDOM()
end

function FzSetModule:GetDOM()
	return self._m_Set:GetDOM()
end

function FzSetModule:ORwithDOM(val)
	self._m_Set:ORwithDOM(val)
end

return FzSetModule
