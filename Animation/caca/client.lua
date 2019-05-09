Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
	    if IsControlJustReleased(0, 47) then
	    	vomit()
	    end  
	end
end)

function caca()
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true) --c'est plus réel sans armes ^^

            anim_dico = "missfbi3ig_0"
            anim_nom = "shit_loop_trev"
	        RequestAnimDict(anim_dico) --Animation
	        while not HasAnimDictLoaded(anim_dico) do --tant que Anim pas charger
	            Citizen.Wait(10)
	        end 


	        local particleDictionary = "scr_amb_chop" --particule 
	    	local particleName = "ent_anim_dog_poo" --particule



		    RequestNamedPtfxAsset(particleDictionary)

		    while not HasNamedPtfxAssetLoaded(particleDictionary) do --tant que particule pas charger
		        Citizen.Wait(0)
		    end

			local PlayerPed = GetPlayerPed(GetPlayerFromServerId(player))

		    SetPtfxAssetNextCall(particleDictionary)

		    local bone = GetPedBoneIndex(PlayerPed, 11816)
		    local effect

	        TaskPlayAnim(PlayerPedId(), anim_dico, anim_nom, 8.0, -8, -1, 0, 0, 0, 0, 0) --Animation
	        effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, -0.15, -0.1, -140.0, 0.0, 0.0, bone, 1.1, false, false, false) --https://runtime.fivem.net/doc/natives/#_0xF28DA9F38CD1787C
	        
	        Wait(6000) --fais lanimation pendant 7s
	        ClearPedTasks(PlayerPedId())
            StopParticleFxLooped(effect, 0)
end

function vomit()
            anim_dico = "anim@amb@business@cfm@cfm_machine_oversee@"
            anim_nom = "cough_spit_operator"
            RequestAnimDict(anim_dico) --Animation
            while not HasAnimDictLoaded(anim_dico) do --tant que Anim pas charger
                Citizen.Wait(10)
            end 


            --local particleDictionary = "scr_amb_chop" --particule 
            --local particleName = "ent_anim_dog_poo" --particule

            local particleDictionary = "cut_paletoscore" --particule 
            local particleName = "cs_paleto_vomit" --particule

            RequestNamedPtfxAsset(particleDictionary)

            while not HasNamedPtfxAssetLoaded(particleDictionary) do --tant que particule pas charger
                Citizen.Wait(0)
            end

            local PlayerPed = GetPlayerPed(GetPlayerFromServerId(player))

            SetPtfxAssetNextCall(particleDictionary)

            local bone = GetPedBoneIndex(PlayerPed, 46240)
            local effect

            TaskPlayAnim(PlayerPedId(), anim_dico, anim_nom, 8.0, -8, -1, 0, 0, 0, 0, 0) --Animation
            effect = StartParticleFxLoopedOnPedBone(particleName, PlayerPed, 0.0, 0.35, 0.5, -140.0, 0.0, 0.0, bone, 1.1, false, false, false) --https://runtime.fivem.net/doc/natives/#_0xF28DA9F38CD1787C
            
            Wait(6000) --fais lanimation pendant 7s
            ClearPedTasks(PlayerPedId())
            StopParticleFxLooped(effect, 0)

end

