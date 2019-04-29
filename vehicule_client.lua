--Script par Malau#9999
RegisterCommand('killme', function()
	local pedPlayer = GetPlayerPed(-1)
	local vehiculePed = GetVehiclePedIsUsing(pedPlayer)
	SetPedIntoVehicle(pedPlayer,vehiculePed,0)


	--ApplyDamageToPed(GetPlayerPed(-1),100000,false)
	notify("~r~ Passager")
end)


Citizen.CreateThread(function()
	--https://docs.fivem.net/game-references/controls/
	local key_on = 300  -- fleche vers le haut                  71 INPUT_VEH_ACCELERATE
	local key = 36 --INPUT_DUCK


	while true do
		Citizen.Wait(1)
		if siDansVehicule() == 1 then
			local pedPlayer = GetPlayerPed(-1)
			
			local vehiculePed = GetVehiclePedIsUsing(pedPlayer)


				if GetVehicleWheelSpeed(vehiculePed,0) == 0.0 then -- SI le vehicule n'est pas en mouvement
					if IsControlPressed(0, key_on) then --Si TOUCHE presser
						if GetIsVehicleEngineRunning(vehiculePed) == false then -- Revoie le statut du vehicule On/off
							demarerMoteur(vehiculePed,pedPlayer,true)
						else
							demarerMoteur(vehiculePed,pedPlayer,false)
						end
					end
				end
		else
			Citizen.Wait(1000)
		end
	end
end)




function siDansVehicule()

	local pedPlayer = GetPlayerPed(-1) --Le Joueur lui même

	if ( IsPedSittingInAnyVehicle( pedPlayer ) ) then --S'il est dans une voiture
		return 1
	else
		return 0
	end
end


function demarerMoteur(vehiculePed, pedPlayer,statut)
	
	if (GetPedInVehicleSeat(vehiculePed, -1) == pedPlayer) then
		SetVehicleEngineOn(vehiculePed, statut, false, true) --Allumage ou Arrêt Moteur Physiquement
		Citizen.Wait(1000)
		if statut == true then
			notify("~g~ Moteur allumé")
		else
			notify("~r~ Moteur éteint")
		end
		
	else
		notify("~r~ Vous n'êtes pas le conducteur")
		Citizen.Wait(1000)
	end
end



--------------------------------GESTION AFFICHAGE-----------------------
function alert(msg) --notif en haut a gauche

    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function notify(striing)--notification au dessus de la carte
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(striing)
    DrawNotification_2(true, false)
end