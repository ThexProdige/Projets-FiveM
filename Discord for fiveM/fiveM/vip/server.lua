local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local identifiers = GetPlayerIdentifiers(player)

    Wait(0)


    local _steam_id = ""
	local _discord_id = ""

	for k,v in pairs(GetPlayerIdentifiers(player))do
      if string.sub(v, 1, string.len("steam:")) == "steam:" then
        _steam_id = v
      elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
        _discord_id = string.sub(v,9)
      end
    
	end

	if _discord_id ~= "" then
		local verif = MySQL.Sync.fetchScalar(
			"SELECT COUNT(1) FROM `vip_table` WHERE `discord_id` = '" .. _discord_id .."' AND `premium` = 1")
			if (verif == 1) then
				MySQL.Sync.fetchScalar(
					"UPDATE `vip_table` SET `identifier` = '" .. _steam_id .. "' WHERE `discord_id` = " .. _discord_id) --associer ID discord à Steam

			end
	end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)