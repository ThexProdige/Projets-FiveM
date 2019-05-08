--#Limiteur υɒlɒM#9999
Citizen.CreateThread(function()
	local key_on = 29 -- TOUCHE B https://docs.fivem.net/game-references/controls/
	local activer = false
	local vitesse = 0
	while true do
		Citizen.Wait(0)
		if siDansVehicule() == 1 then
			local pedPlayer = GetPlayerPed(-1)
			
			local veh = GetVehiclePedIsUsing(pedPlayer)
			
			
			if IsControlPressed(0, key_on)then 
				vitesse = GetEntitySpeed(veh) 

				if activer == false then --correspond a 30km/h
					

					if vitesse < 1 then-- pour evité certains bugg quand on veut limiter une vitesse qui est à Zéro
						Citizen.Wait(500)
					else
						activer = true
						SetEntityMaxSpeed(veh,vitesse)

						vitesse = math.ceil(vitesse * 3.6)-- convertis  et arrondi les m/s en Km/s 

						exports.pNotify:SendNotification({
	                            text = "Limiteur sur " ..vitesse.." km/h",
	                            type = "success",
	                            opacity = 100,
	                            layout = "centerRight",
	                            timeout = 3000
	                        })
						Citizen.Wait(500)
					end
				else
					activer = false
					SetEntityMaxSpeed(veh,9999.0) -- Le vehicule sera au max de ses capacité 
					exports.pNotify:SendNotification({
                            text = "Limiteur désactivé",
                            type = "warning",
                            opacity = 100,
                            layout = "centerRight",
                            timeout = 3000
                        })
					Citizen.Wait(500)
				end
			end
		else
			activer = false
		end


	end


end)

function siDansVehicule()

	local pedPlayer = GetPlayerPed(-1) --Le Joueur lui même

	if ( IsPedSittingInAnyVehicle( pedPlayer ) ) then --S'il est dans une voiture
		local veh = GetVehiclePedIsUsing(pedPlayer)

		if (GetPedInVehicleSeat(veh, -1) == pedPlayer) then-- S'il est le conducteur
			return 1
		else
			return 0
		end
	else
		return 0
	end
end