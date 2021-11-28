local FuzzyTerm = require(script.Parent.FuzzyTermModule)
--local FuzzySet = require(script.Parent.FuzzySet.FuzzySetModule)

local FzAndModule = class('FzAndModule', FuzzyTerm)

function FzAndModule:initialize(...)
	self._m_Terms = {}
	for _,v in ipairs({...}) do
		table.insert(self._m_Terms, v)
	end
end

function FzAndModule:ClearDOM()
	for k,v in ipairs(self._m_Terms) do
		v:ClearDOM()
	end
end

function FzAndModule:GetDOM()
	local smallest = 1000000
	
	for k,v in ipairs(self._m_Terms) do
		if v:GetDOM() < smallest then
			smallest = v:GetDOM()
		end
	end
	
	return smallest
end

function FzAndModule:ORwithDOM(val)
	for k,v in ipairs(self._m_Terms) do
		v:ORwithDOM(val)
	end
end

return FzAndModule
