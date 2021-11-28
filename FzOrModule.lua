local FuzzyTerm = require(script.Parent.FuzzyTermModule)
--local FuzzySet = require(script.Parent.FuzzySet.FuzzySetModule)

local FzOrModule = class('FzOrModule', FuzzyTerm)

function FzOrModule:initialize(...)
	self._m_Terms = {}
	for _,v in ipairs({...}) do
		table.insert(self._m_Terms, v)
	end
end

function FzOrModule:ClearDOM()
	for k,v in ipairs(self._m_Terms) do
		v:ClearDOM()
	end
end

function FzOrModule:GetDOM()
	local largest = -1
	
	for k,v in ipairs(self._m_Terms) do
		if v:GetDOM() > largest then
			largest = v:GetDOM()
		end
	end
	
	return largest
end

function FzOrModule:ORwithDOM(val)
	for k,v in ipairs(self._m_Terms) do
		v:ORwithDOM(val)
	end
end

return FzOrModule
