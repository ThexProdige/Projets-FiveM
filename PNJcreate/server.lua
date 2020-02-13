RegisterServerEvent("addPNJBDD")
AddEventHandler("addPNJBDD", function(param)--ajoute le pnj a la BDD
	if IsPlayerAceAllowed(source, "administrator") or onlyAdmin == false then

		local addPNJ = MySQL.Sync.fetchScalar(
			"INSERT INTO " .. nomTable .. " (type,model,posx,posy,posz,rot) VALUES ('".. param[1] .."','" .. param[2].."','" .. param[3].."','" .. param[4] .."','" .. param[5] .."','" .. param[6] .."')") --ajout du PNJ dans la BDD
		loadBDD()
	else
		print( source .. " à tenté de creer un PNJ")
	end
end)

RegisterServerEvent('clientserverID')
AddEventHandler('clientserverID', function(playerid)
	Citizen.Wait(0)
	source = playerid
	onlyAdmin = false --Interdire les non-admin a creer des pnj
	loadBDD()
end)

function loadBDD() --charge les pnj au chargement
	nomTable = "eldo_PNJ"
	Citizen.Wait(0)
	MySQL.Async.fetchAll('SELECT * FROM '.. nomTable, {}, function(players)

		TriggerClientEvent("loadPNJBDD", source, players)

	end)
end

function delBDD()


end