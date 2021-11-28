local FuzzyRuleModule = class('FuzzyRuleModule')

function FuzzyRuleModule:initialize(ant, cons)
	self._m_Antecedent = ant
	self._m_Consequence = cons
end

function FuzzyRuleModule:SetConfidencesOfConsequentsToZero()
	self._m_Consequence:ClearDOM()
end

function FuzzyRuleModule:Calculate()
	self._m_Consequence:ORwithDOM(self._m_Antecedent:GetDOM())
end

return FuzzyRuleModule
