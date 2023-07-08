local pedsReady = false

function SpawnPeds()
	if pedsReady or not next(Peds) then return end
	for k, v in pairs(Peds) do
		if not v.currentpednumber or v.currentpednumber == 0 then
			local spawnedped

            lib.requestModel(v.model, 500)

			if type(v.model) == 'string' then v.model = joaat(v.model) end

			if v.minusOne then
				spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, v.networked or false, false)
			else
				spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, v.networked or false, false)
			end

			if v.freeze then
				FreezeEntityPosition(spawnedped, true)
			end

			if v.invincible then
				SetEntityInvincible(spawnedped, true)
			end

			if v.blockevents then
				SetBlockingOfNonTemporaryEvents(spawnedped, true)
			end

			if v.animDict and v.anim then
				RequestAnimDict(v.animDict)
				while not HasAnimDictLoaded(v.animDict) do
					Wait(0)
				end

				TaskPlayAnim(spawnedped, v.animDict, v.anim, 8.0, 0, -1, v.flag or 1, 0, 0, 0, 0)
			end

			if v.scenario then
				if v.scenariolower then
					local coords = GetEntityCoords(spawnedped)
					local heading = GetEntityHeading(spawnedped)
					TaskStartScenarioAtPosition(spawnedped, v.scenario, coords.x, coords.y, coords.z-v.scenariolower, heading, -1, true, true)
				else
					TaskStartScenarioInPlace(spawnedped, v.scenario, 0, true)
				end
			end

			if v.target then
				if v.target.useModel then
					exports["qb-target"]:AddTargetModel(v.model, {
						options = v.target.options,
						distance = v.target.distance
					})
				else
					exports["qb-target"]:AddTargetEntity(spawnedped, {
						options = v.target.options,
						distance = v.target.distance
					})
				end
			end

			Peds[k].currentpednumber = spawnedped
		end
	end
	pedsReady = true
end

function DeletePeds()
	if not pedsReady or not next(Peds) then return end
	for k, v in pairs(Peds) do
		DeletePed(v.currentpednumber)
		Peds[k].currentpednumber = 0
	end
	pedsReady = false
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    SpawnPeds()
end)

-- This is to make sure the peds spawn on restart too instead of only when you load/log-in.
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		SpawnPeds()
	end
end)

-- This will delete the peds when the resource stops to make sure you don't have random peds walking
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		DeletePeds()
	end
end)

local function SpawnPed(data)
	local spawnedped
	local key, value = next(data)
	if type(value) == 'table' and type(key) ~= 'string' then
		for _, v in pairs(data) do
			if v.spawnNow then
				RequestModel(v.model)
				while not HasModelLoaded(v.model) do
					Wait(0)
				end

				if type(v.model) == 'string' then v.model = joaat(v.model) end

				if v.minusOne then
					spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w or 0.0, v.networked or false, true)
				else
					spawnedped = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w or 0.0, v.networked or false, true)
				end

				if v.freeze then
					FreezeEntityPosition(spawnedped, true)
				end

				if v.invincible then
					SetEntityInvincible(spawnedped, true)
				end

				if v.blockevents then
					SetBlockingOfNonTemporaryEvents(spawnedped, true)
				end

				if v.animDict and v.anim then
					RequestAnimDict(v.animDict)
					while not HasAnimDictLoaded(v.animDict) do
						Wait(0)
					end

					TaskPlayAnim(spawnedped, v.animDict, v.anim, 8.0, 0, -1, v.flag or 1, 0, 0, 0, 0)
				end

				if v.scenario then
					if v.scenariolower then
						local coords = GetEntityCoords(spawnedped)
						local heading = GetEntityHeading(spawnedped)
						TaskStartScenarioAtPosition(spawnedped, v.scenario, coords.x, coords.y, coords.z-v.scenariolower, heading, -1, true, true)
					else
						TaskStartScenarioInPlace(spawnedped, v.scenario, 0, true)
					end
				end
				if v.target then
					if v.target.useModel then
						exports["qb-target"]:AddTargetModel(v.model, {
							options = v.target.options,
							distance = v.target.distance
						})
					else
						exports["qb-target"]:AddTargetEntity(spawnedped, {
							options = v.target.options,
							distance = v.target.distance
						})
					end
				end

				v.currentpednumber = spawnedped
			end

			local nextnumber = #Peds + 1
			if nextnumber <= 0 then nextnumber = 1 end

			Peds[nextnumber] = v
		end
	else
		if data.spawnNow then
			RequestModel(data.model)
			while not HasModelLoaded(data.model) do
				Wait(0)
			end

			if type(data.model) == 'string' then data.model = joaat(data.model) end

			if data.minusOne then
				spawnedped = CreatePed(0, data.model, data.coords.x, data.coords.y, data.coords.z - 1.0, data.coords.w, data.networked or false, true)
			else
				spawnedped = CreatePed(0, data.model, data.coords.x, data.coords.y, data.coords.z, data.coords.w, data.networked or false, true)
			end

			if data.freeze then
				FreezeEntityPosition(spawnedped, true)
			end

			if data.invincible then
				SetEntityInvincible(spawnedped, true)
			end

			if data.blockevents then
				SetBlockingOfNonTemporaryEvents(spawnedped, true)
			end

			if data.animDict and data.anim then
				RequestAnimDict(data.animDict)
				while not HasAnimDictLoaded(data.animDict) do
					Wait(0)
				end

				TaskPlayAnim(spawnedped, data.animDict, data.anim, 8.0, 0, -1, data.flag or 1, 0, 0, 0, 0)
			end

			if data.scenario then
				SetPedCanPlayAmbientAnims(spawnedped, true)
				TaskStartScenarioInPlace(spawnedped, data.scenario, 0, true)
			end

			if data.target then
				if data.target.useModel then
					exports["qb-target"]:AddTargetModel(data.model, {
						options = data.target.options,
						distance = data.target.distance
					})
				else
					exports["qb-target"]:AddTargetEntity(spawnedped, {
						options = data.target.options,
						distance = data.target.distance
					})
				end
			end

			data.currentpednumber = spawnedped
		end

		local nextnumber = #Peds + 1
		if nextnumber <= 0 then nextnumber = 1 end

		Peds[nextnumber] = data
		if spawnedped then
			return spawnedped
		end
	end
end

exports("SpawnPed", SpawnPed)

local function RemovePed(peds)
	if type(peds) == 'table' then
		for k, v in pairs(peds) do
			DeletePed(v)
			if Peds[k] then Peds[k].currentpednumber = 0 end
		end
	elseif type(peds) == 'number' then
		DeletePed(peds)
	end
end

exports("RemoveSpawnedPed", RemovePed)