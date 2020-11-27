ModUtil.RegisterMod( "ExportRunHistory" )

function ExportRunHistory.true_export() --to prevent crash when 64bit version is run
	if pcall(ExportRunHistory.Export) then
		print("good")
	else
		print("bad")
	end
end

function ExportRunHistory.Export()
	local file = io.open("C:/Users/admin/projects/hades_run_exporter/output/output.json", "w")
	local total_runs = TableLength( GameState.RunHistory ) + 1
	local runs_json = '{"runs": ['
	local index = 1
	while index <= total_runs do
		local run
		if index == total_runs then
			run = CurrentRun
		else
			run = GameState.RunHistory[index]
		end
		local index_formatted = '"index": ' .. index .. ","

		--Result
		local resultText = '"RunHistoryScreen_Cleared"'
		if not run.Cleared then
			local roomData = RoomData[run.EndingRoomName]
			if roomData ~= nil then
				resultText = '"' .. roomData.ResultText .. '"'
			else
				resultText = "RunHistoryScreen_Missing"
			end
		end
		local result_f = '"result":' .. resultText .. ","

		--Time
		local runTime = '"' .. GetTimerString( run.GameplayTime, 2 ) .. '"'
		local time_f = '"time": ' .. runTime .. ","

		--Clear Message
		local clearMessage = '""'
		if run.RunClearMessage ~= nil then
			clearMessage = '"' .. run.RunClearMessage.Name .. '"'
		end
		clearMessage_f = '"clearMessage": ' .. clearMessage .. ","
		
		--Weapon
		local weaponText = "RunHistoryScreen_Missing"
		if run.WeaponsCache ~= nil then
			for k, weaponName in ipairs( WeaponSets.HeroMeleeWeapons ) do
				if run.WeaponsCache[weaponName] then
					weaponText = '"' .. weaponName .. '"'
				end
			end
		end
		local weapon_f = '"weapon": ' .. weaponText .. ","

		--Aspect
		local aspectText = '""'
		if run.TraitCache ~= nil then
			for traitName, count in pairs( run.TraitCache ) do
				local traitData = TraitData[traitName]
				if traitData ~= nil and traitData.IsWeaponEnchantment then
					aspectText = '"' .. traitName .. '"'
					break
				end
			end
		end
		local aspect_f = '"aspect": ' .. aspectText .. ","
		
		--Keepsake
		local keepsakeText = '""'
		if run.EndingKeepsakeName ~= nil then
			keepsakeText = '"' .. run.EndingKeepsakeName .. '"'
		elseif run.TraitCache ~= nil then
			for traitName, count in pairs( run.TraitCache ) do
				local traitData = TraitData[traitName]
				if traitData ~= nil and traitData.Slot == "Keepsake" then
					keepsakeText = '"' .. traitName .. '"'
					break
				end
			end
		end
		local keepsake_f = '"keepsake": ' .. keepsakeText .. ","

		--Companion
		local companionText = '""'
		if run.TraitCache ~= nil then
			for traitName, count in pairs( run.TraitCache ) do
				local traitData = TraitData[traitName]
				if traitData ~= nil and traitData.Slot == "Assist" then
					companionText = '"' .. traitName .. '"'
					break
				end
			end
		end
		local companion_f = '"companion": ' .. companionText .. ","
		
		-- Boons and other stuff
		local trait = '"trait": ['
		local first = 0
		if run.TraitCache ~= nil then
			for traitName, count in pairs( run.TraitCache ) do
				local individualTrait = '{"traitName":' .. '"' .. traitName .. '"' .. ',"traitLevel":' .. count .. "},"
				trait = trait .. individualTrait
			end
			trait = trait:sub(1, -2) --strips trailing comma because json reasons
		end
		trait = trait .. "]" .. ","

		--Heat
		local heatPoints = 0
		local heat = '"heat": ['
		if run.ShrinePointsCache ~= nil and run.ShrinePointsCache > 0 then
			heatPoints = run.ShrinePointsCache
			for k, upgradeName in ipairs( ShrineUpgradeOrder ) do
				local upgradeData = MetaUpgradeData[upgradeName]
				local numUpgrades = run.MetaUpgradeCache[upgradeName] or 0
				if numUpgrades > 0 then
					local individualHeat = '{"heatName":' .. '"' .. GetMetaUpgradeShortTotalText( upgradeData, true, numUpgrades ) .. '"' .. ',"heatLevel":' .. GetTotalStatChange( upgradeData, numUpgrades ) .. "},"
					heat = heat .. individualHeat
				end
			end
			heat = heat:sub(1, -2)
		end
		local heatPoints_f = '"heatPoints": ' .. heatPoints .. ","
		heat = heat .. "]" .. ","

		--Darkness
		local darknessPoints = 0
		local darkness = '"darkness": ['
		if run.MetaPointsCache ~= nil and run.MetaPointsCache > 0 then
			if run.MetaPointsCache ~= nil then
				darknessPoints = run.MetaPointsCache
			end
			for k, upgradePair in ipairs( MetaUpgradeOrder ) do
				local upgradeA = upgradePair[1]
				local upgradeB = upgradePair[2]
				if run.MetaUpgradeCache[upgradeB] ~= nil then
					upgradeName = upgradeB
				else
					upgradeName = upgradeA
				end
				local upgradeData = MetaUpgradeData[upgradeName]
				local numUpgrades = run.MetaUpgradeCache[upgradeName] or 0
				if numUpgrades > 0 then
					local individualDarkness = '{"darknessName":' .. '"' .. GetMetaUpgradeShortTotalText( upgradeData, true, numUpgrades ) .. '"' .. ',"darknessLevel":' .. GetTotalStatChange( upgradeData, numUpgrades ) .. "},"
					darkness = darkness .. individualDarkness
				end
			end
			darkness = darkness:sub(1, -2)
		end
		local darknessPoints_f = '"darknessPoints": ' .. darknessPoints .. ","
		darkness = darkness .. "]"

		local run_formatted = '{' .. index_formatted .. result_f .. time_f .. 
		clearMessage_f .. weapon_f .. aspect_f .. 
		keepsake_f .. companion_f .. trait .. 
		heatPoints_f .. heat .. darknessPoints_f .. darkness .. "}"

		runs_json = runs_json .. run_formatted .. ","
		index = index + 1
	end
	runs_json = runs_json:sub(1, -2)
	runs_json = runs_json .. "]}"
	file:write(runs_json)
	file:close()
end

-- --navy seal copypasta
-- function ExportRunHistory.Export()
-- 	local screen = DeepCopyTable( ScreenData.RunHistory )
-- 	local keys = ModUtil.TableKeysString( screen )
-- 	ModUtil.Hades.PrintOverhead("What the fuck did you just fucking say about me, you little bitch? I'll have you know I graduated top of my class in the Navy Seals...")
-- 	return keys
-- end
	
-- OnAnyLoad {
-- 	--DumpRunHistoryStats
-- 	ExportRunHistory.Export
	
-- }

ModUtil.LoadOnce( 
	ExportRunHistory.true_export
)
