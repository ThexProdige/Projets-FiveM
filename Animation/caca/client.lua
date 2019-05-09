Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	    if IsControlJustReleased(0, 47) then
	    	vomit()
	    end  
	end
end)


function animation(anim_dico,anim_nom,particle_dico,particle_name,px,py,pz,rx,ry,rz,deciBone,taille,lx,ly,lz)
	SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true) --c'est plus réel sans armes ^^

	RequestAnimDict(anim_dico) --Animation
	while not HasAnimDictLoaded(anim_dico) do --tant que Anim pas charger
	    Citizen.Wait(10)
	end 

	RequestNamedPtfxAsset(particle_dico)

	while not HasNamedPtfxAssetLoaded(particle_dico) do --tant que particule pas charger
		Citizen.Wait(0)
	end

	local PlayerPed = GetPlayerPed(GetPlayerFromServerId(player))

	SetPtfxAssetNextCall(particle_dico)

	local bone = GetPedBoneIndex(PlayerPed, deciBone)
	local effect

	TaskPlayAnim(PlayerPedId(), anim_dico, anim_nom, 8.0, -8, -1, 0, 0, 0, 0, 0) --Animation

	effect = StartParticleFxLoopedOnPedBone(particle_name, PlayerPed, px, py, pz, rx, ry, rz, bone, taille, lx, ly, lz) --https://runtime.fivem.net/doc/natives/#_0xF28DA9F38CD1787C
	        
	Wait(6000) --fais lanimation pendant 7s
	ClearPedTasks(PlayerPedId())
    StopParticleFxLooped(effect, 0)
end


function caca()
	animation("missfbi3ig_0","shit_loop_trev","scr_amb_chop","ent_anim_dog_poo",0.0,0.0,-0.7,0.0,0.0,20.0,11816,1.1,false, false, false)    
end

function vomit()
	animation("anim@amb@business@cfm@cfm_machine_oversee@","cough_spit_operator","cut_paletoscore","cs_paleto_vomit",0.0,0.35,0.5,-140.0,0.0,0.0,46240,1.1,false, false, false)

end

