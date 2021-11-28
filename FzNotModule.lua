local FuzzyTerm = require(script.Parent.FuzzyTermModule)
--local FuzzySet = require(script.Parent.FuzzySet.FuzzySetModule)

local FzNotModule = class('FzNotModule', FuzzyTerm)

function FzNotModule:initialize(fs)
	self._m_Set = fs._m_Set
end

function FzNotModule:ClearDOM()
	self._m_Set:ClearDOM()
end

function FzNotModule:GetDOM()
	return 1 - self._m_Set:GetDOM()
end

function FzNotModule:ORwithDOM(val)
	self._m_Set:ORwithDOM(1 - val)
end

return FzNotModule
