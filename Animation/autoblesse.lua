Citizen.CreateThread(function()
	while true do
		Wait(500)
		if GetEntityHealth(GetPlayerPed(-1)) <= 120 then
			setHurt()
		elseif GetEntityHealth(GetPlayerPed(-1)) > 121 then
			setNotHurt()
		end
	end
end)

function setHurt()
	anim_dico = "move_injured_generic"
	RequestAnimSet(anim_dico)
	SetPedMovementClipset(GetPlayerPed(-1), anim_dico, true)
	SetEntityMaxSpeed(GetPlayerPed(-1),3.3)

	
end

function setNotHurt()
	ResetPedMovementClipset(GetPlayerPed(-1))
	ResetPedWeaponMovementClipset(GetPlayerPed(-1))
	ResetPedStrafeClipset(GetPlayerPed(-1))
	SetEntityMaxSpeed(GetPlayerPed(-1),10.0)
end