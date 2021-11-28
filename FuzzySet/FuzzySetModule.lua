local FuzzySetModule = class('FuzzySetModule')

function FuzzySetModule:initialize(RepVal)
	self.m_dDOM = 0.0
	self.m_dRepresentativeValue = RepVal
end

function FuzzySetModule:CalculateDOM(val)

end

function FuzzySetModule:ORwithDOM(val)
	if val > self.m_dDOM then
		self.m_dDOM = val
	end
end

function FuzzySetModule:ClearDOM()
	self.m_dDOM = 0.0
end

function FuzzySetModule:GetRepresentativeValue()
	return self.m_dRepresentativeValue
end

function FuzzySetModule:GetDOM()
	return self.m_dDOM
end

function FuzzySetModule:SetDOM(val)
	if val <= 1.0 and val >= 0.0 then
		self.m_dDOM = val
	end
end

return FuzzySetModule
