local FuzzySetLeftShoulder = require(script.Parent.FuzzySet.FuzzySetLeftShoulderModule)
local FuzzySetRightShoulder = require(script.Parent.FuzzySet.FuzzySetRightShoulderModule)
local FuzzySetTriangle = require(script.Parent.FuzzySet.FuzzySetTriangleModule)
local FuzzySetSingleton = require(script.Parent.FuzzySet.FuzzySetSingletonModule)
local FuzzySetTrapezoid = require(script.Parent.FuzzySet.FuzzySetTrapezoidModule)
local FuzzySetSigmoid = require(script.Parent.FuzzySet.FuzzySetSigmoidModule)

local FzSet = require(script.Parent.FzSetModule)

local FuzzyVariableModule = class('FuzzyVariableModule')

function FuzzyVariableModule:initialize()
	self._m_MemberSets = {}
	self._m_dMinRange = 0.0
	self._m_dMaxRange = 0.0
end

local _AdjustRangeToFit = function (self, minBound, maxBound)
	if self._m_dMinRange > minBound then
		self._m_dMinRange = minBound
	end
	if self._m_dMaxRange < maxBound then
		self._m_dMaxRange = maxBound
	end
end

function FuzzyVariableModule:AddLeftShoulderSet(name, minBound, peak, maxBound)
	assert((peak < maxBound) and (peak >= minBound), "Error: Incorrect value in generate "..name.." LeftShoulderSet!")
	self._m_MemberSets[name] = FuzzySetLeftShoulder:new(peak, peak-minBound, maxBound-peak)
	_AdjustRangeToFit(self, minBound, maxBound)
	return FzSet:new(self._m_MemberSets[name])
end

function FuzzyVariableModule:AddRightShoulderSet(name, minBound, peak, maxBound)
	assert((peak <= maxBound) and (peak > minBound), "Error: Incorrect value in generate "..name.." RightShoulderSet!")
	self._m_MemberSets[name] = FuzzySetRightShoulder:new(peak, peak-minBound, maxBound-peak)
	_AdjustRangeToFit(self, minBound, maxBound)
	return FzSet:new(self._m_MemberSets[name])
end

function FuzzyVariableModule:AddTriangularSet(name, minBound, peak, maxBound)
	assert((peak <= maxBound) and (peak >= minBound), "Error: Incorrect value in generate "..name.." TriangularSet!")
	self._m_MemberSets[name] = FuzzySetTriangle:new(peak, peak-minBound, maxBound-peak)
	_AdjustRangeToFit(self, minBound, maxBound)
	return FzSet:new(self._m_MemberSets[name])
end

function FuzzyVariableModule:AddSingletonSet(name, minBound, peak, maxBound)
	assert((peak <= maxBound) and (peak >= minBound), "Error: Incorrect value in generate "..name.." SingletonSet!")
	self._m_MemberSets[name] = FuzzySetSingleton:new(peak, peak-minBound, maxBound-peak)
	_AdjustRangeToFit(self, minBound, maxBound)
	return FzSet:new(self._m_MemberSets[name])
end

function FuzzyVariableModule:AddTrapezoidSet(name, minBound, leftpeak, rightpeak, maxBound)
	assert((rightpeak > leftpeak) and (rightpeak <= maxBound) and (leftpeak >= minBound) , "Error: Incorrect value in generate "..name.." TrapezoidSet!")
	self._m_MemberSets[name] = FuzzySetTrapezoid:new(leftpeak, rightpeak, leftpeak-minBound, maxBound-rightpeak)
	_AdjustRangeToFit(self, minBound, maxBound)
	return FzSet:new(self._m_MemberSets[name])
end

function FuzzyVariableModule:AddSigmoidSet(name, minBound, mid, maxBound, k)
	assert((mid <= maxBound) and (mid >= minBound), "Error: Incorrect value in generate "..name.." SigmoidSet!")
	k = k or 1
	self._m_MemberSets[name] = FuzzySetSigmoid:new(mid, mid-minBound, maxBound-mid, k)
	_AdjustRangeToFit(self, minBound, maxBound)
	return FzSet:new(self._m_MemberSets[name])
end

function FuzzyVariableModule:Fuzzify(val)
	assert(val <= self._m_dMaxRange and val >= self._m_dMinRange, "Value out of range in Fuzzify.")
	for k,v in pairs(self._m_MemberSets) do
		v:SetDOM(v:CalculateDOM(val))
	end
end

function FuzzyVariableModule:DeFuzzifyMaxAv()
	local bottom = 0.0
	local top = 0.0
	
	for k,v in pairs(self._m_MemberSets) do
		bottom = bottom + v:GetDOM()
		top = top + v:GetRepresentativeValue() * v:GetDOM()
	end
	
	if bottom == 0.0 then
		return 0.0
	end
	
	return top/bottom
end

function FuzzyVariableModule:DeFuzzifyCentroid(NumSamples)
	local StepSize = (self._m_dMaxRange - self._m_dMinRange) / NumSamples
	local TotalDOM = 0.0
	local SumOfStep = 0.0
	
	for i = 1, NumSamples do
		for k,v in pairs(self._m_MemberSets) do
			local sDOM = math.min(v:GetDOM(), v:CalculateDOM(self._m_dMinRange + StepSize * i))
			TotalDOM = TotalDOM + sDOM
			SumOfStep = SumOfStep + sDOM * (self._m_dMinRange + StepSize * i)
		end
	end
	
	if TotalDOM == 0.0 then
		return 0.0
	end
	
	return SumOfStep / TotalDOM
end

function FuzzyVariableModule:PrintDOMs()
	for k,v in pairs(self._m_MemberSets) do
		print(k..": "..v:GetDOM())
	end
end

return FuzzyVariableModule
