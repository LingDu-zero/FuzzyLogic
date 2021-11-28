local FuzzyVariable = require(script.Parent.FuzzyVariableModule)
local FuzzyRule = require(script.Parent.FuzzyRuleModule)

local FuzzyModule = class('FuzzyModule')

function FuzzyModule:initialize(NumSamples, Debug)
	self.NumSamples = NumSamples or 15
	self._Debug = Debug or false
	self.DefuzzifyType = {'maxav', 'centroid'}
	self._m_Variables = {}
	self._m_Rules = {}
end

local _SetConfidencesOfConsequentsToZero = function (self)
	for k,v in ipairs(self._m_Rules) do
		v:SetConfidencesOfConsequentsToZero()
	end
end

function FuzzyModule:CreateFLV(VarName)
	self._m_Variables[VarName] = FuzzyVariable:new()
	return self._m_Variables[VarName]
end

function FuzzyModule:AddRule(antecendent, consequence)
	table.insert(self._m_Rules, FuzzyRule:new(antecendent, consequence))
end

function FuzzyModule:Fuzzify(NameOfFLV, val)
	assert(self._m_Variables[NameOfFLV] ~= nil, "key not found")
	self._m_Variables[NameOfFLV]:Fuzzify(val)
	
	if self._Debug then
		self._m_Variables[NameOfFLV]:PrintDOMs()
	end
end

function FuzzyModule:DeFuzzify(NameOfFLV, method)
	assert(self._m_Variables[NameOfFLV] ~= nil, "key not found")
	_SetConfidencesOfConsequentsToZero(self)
	
	for k,v in ipairs(self._m_Rules) do
		v:Calculate()
	end
	
	if self._Debug then
		self._m_Variables[NameOfFLV]:PrintDOMs()
	end
	
	if method == self.DefuzzifyType[1] then
		return self._m_Variables[NameOfFLV]:DeFuzzifyMaxAv()
	elseif method == self.DefuzzifyType[2] then
		return self._m_Variables[NameOfFLV]:DeFuzzifyCentroid(self.NumSamples)
	else
		return 0
	end
	
	return 0
end

function FuzzyModule:PrintFLV()
	for k,v in pairs(self._m_Variables) do
		print(k)
	end
end

return FuzzyModule
