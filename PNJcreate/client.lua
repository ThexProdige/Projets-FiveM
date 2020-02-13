RegisterNetEvent('loadPNJBDD')
AddEventHandler('loadPNJBDD', function(players)
	local ctr = 1
	for index in pairs(players) do
		local pnj = {players[ctr].type, players[ctr].model,players[ctr].posx,

					players[ctr].posy,players[ctr].posz, players[ctr].rot}

		createPNJ(pnj[1],pnj[2],pnj[3],pnj[4],pnj[5],pnj[6])

		ctr = ctr + 1
	end
	print('PNJ Chargé')

end)



function createPNJ(type,nameModel,x,y,z,rot)-- TYPE : 4 HOMME; 5 MEUF.  MODEL : https://wiki.rage.mp/index.php?title=Peds
	local hash = GetHashKey(nameModel)
	RequestModel(hash)
	while not HasModelLoaded(hash) do
		Wait(1)
	end

	
	local ped = CreatePed(type,hash,x,y,z,rot,false,true)
	FreezeEntityPosition(ped, true) -- on freeze le ped pour pas qu'il bouge
	SetEntityInvincible(ped, true) -- On le rend intuable !
	SetBlockingOfNonTemporaryEvents(ped, true)-- NO fear/neutre !
end

Citizen.CreateThread(function() --ont vas les faires spawn
	local playerid = GetPlayerServerId()
	TriggerServerEvent("clientserverID", playerid)-- on envoie le client ID


----MAGASINs DE VETEMENT---
createPNJ(5,"a_f_y_bevhills_01",427.0965, -806.2654, 28.49077, 90.0) --comico
createPNJ(5,"a_f_y_bevhills_01",73.92422, -1393.05, 28.37607, 270.0) --Mecano
createPNJ(5,"a_f_y_bevhills_01",-823.1876, -1072.287, 10.32961, 220.0) --Coter Asie
createPNJ(5,"a_f_y_bevhills_01",-1194.643, -767.4453, 16.31782, 220.0) --Agenceimmo1
createPNJ(5,"a_f_y_bevhills_02",-1193.163, -766.3269, 16.31692, 220.0) --Agenceimmo2
createPNJ(5,"a_f_y_bevhills_01",-1448.841, -238.0294, 48.81371, 50.0) --Agenceimmo NORD
createPNJ(5,"a_f_y_bevhills_01",-708.7073, -151.9618, 36.41536, 120.0) --Coiffeur
createPNJ(5,"a_f_y_bevhills_01",-164.9137, -302.6835, 38.73302, 270.0) --Assurance
createPNJ(5,"a_f_y_bevhills_01",126.6529, -225.2541, 53.55851, 90.0) --Prefecture1
createPNJ(5,"a_f_y_bevhills_01",127.2613, -223.3589, 53.55779, 90.0) --Prefecture2
createPNJ(5,"a_f_y_bevhills_02",-3168.937, 1044.271, 19.86343, 70.0) --Pacific1
createPNJ(5,"a_f_y_bevhills_01",-3169.702, 1042.367, 19.86284, 70.0) --Pacific2
createPNJ(5,"a_f_y_bevhills_02",-1102.453, 2711.527, 18.10901, 230.0) --riviere
createPNJ(5,"a_f_y_bevhills_02",613.0461, 2761.631, 41.08884, 270.0) --PisteAtterissage2-1
createPNJ(5,"a_f_y_bevhills_01",612.8082, 2763.668, 41.08878, 270.0) --PisteAtterissage2-2
createPNJ(5,"a_f_y_bevhills_02",1196.446, 2711.742, 37.22227, 180.0) --PisteAtterissage1
createPNJ(5,"a_f_y_hipster_02",5.872607, 6511.518, 30.8781, 50.0) --ExtremNOrd
------------COMICO-------------------------------
createPNJ(4,"s_m_y_hwaycop_01",440.9299, -978.8535, 29.6897, 180.0) --Comico centre ville
------ELDO_FIT------
createPNJ(4,"s_m_y_baywatch_01",-1195.442, -1576.956, 3.605577, 120.0)--ELDO_FIT

end)

function igCreate(type, namemodel)
	
		ped = GetPlayerPed(-1)
		rotation = GetEntityRotation(ped, 2)
		pos = GetPedBoneCoords(ped, 0x60E6) --on recupère notre position

		 pnj = {type,namemodel,pos.x,pos.y,pos.z,rotation.z}

		TriggerServerEvent("addPNJBDD", pnj)--on passe notre table en parametre pour l'envoyé à la BDD
end

RegisterCommand('pnj', function(source, args)
	igCreate(args[1],args[2])
end,false)

RegisterCommand('pnjundo', function(source, args)
	pedId,entity = FindFirstPed()
	print(pedId .. " " .. entity)
end,false)




