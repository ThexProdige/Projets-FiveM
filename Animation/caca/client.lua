Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	    if IsControlJustReleased(0, 47) then
	    	--SetEntityHealth(GetPlayerPed(-1),100)
	    	vomit()
	    end  
	end
end)

function main()
	anim_dico = "anim@move_f@grooving@slow@"
	anim_nom = "walk"
	RequestAnimDict(anim_dico) --Animation
		while not HasAnimDictLoaded(anim_dico) do --tant que Anim pas charger
		    Citizen.Wait(10)
		end 
	TaskPlayAnim(PlayerPedId(), anim_dico, anim_nom, 8.0, -8, -1, 47, 0, false, false, false) --Animation
	Wait(6000) --fais lanimation pendant 7s
	ClearPedTasks(PlayerPedId())
end






function animation(anim_dico,anim_nom,flag_anim,particle_dico,particle_name,px,py,pz,rx,ry,rz,deciBone,taille,lx,ly,lz) --(STRING,STRING,STRING,STRING,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT,FLOAT,INT,FLOAT,BOOL,BOOL,BOOL)
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

	TaskPlayAnim(PlayerPedId(), anim_dico, anim_nom, 8.0, -8, -1, flag_anim, 0, 0, 0, 0) --Animation
	Wait(4000)
	effect = StartParticleFxLoopedOnPedBone(particle_name, PlayerPed, px, py, pz, rx, ry, rz, bone, taille, lx, ly, lz) --https://runtime.fivem.net/doc/natives/#_0xF28DA9F38CD1787C
	Wait(1550)
	 --fais lanimation pendant 7s
	ClearPedTasks(PlayerPedId())
    StopParticleFxLooped(effect, 0)
end


function caca()
	animation("missfbi3ig_0","shit_loop_trev",0,"scr_amb_chop","ent_anim_dog_poo",0.0,0.0,-0.7,0.0,0.0,20.0,11816,1.1,false, false, false)    
end

function vomit()
	----------PARAMETRE Animation----------
	local anim_dico = "oddjobs@taxi@tie"
	local anim_name = "vomit_outside"

	local flag = 48


	local particule_dico = "cut_paletoscore"
	local particule_name = "cs_paleto_vomit"
	---------PRAMETRE PARTICULE---------------
	local particule_dico = "cut_paletoscore"
	local particule_name = "cs_paleto_vomit"
	local xOff = 0.30
	local yOff = 0.15
	local zOff = 0.55

	local xRot = 0.0
	local yRot = 0.0
	local zRot = 0.0

	local  taille = 2.0
	------------------------------------------------
	animation(anim_dico,anim_name,flag,particule_dico,particule_name,xOff,yOff,zOff,xRot,yRot,zRot,46240,taille,false, false, false)

end

