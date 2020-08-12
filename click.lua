RegisterNetEvent("PatchNotes")
AddEventHandler("PatchNotes", function()
	PatchNotes()
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait(0)
    end
end

function PatchNotes()
	menuEnabled = not menuEnabled
	print("menu opened")
	if (menuEnabled) then 
		SetNuiFocus( true, true ) 
		SendNUIMessage({
			showPlayerMenu = true
		})
	else 
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end
end

DrawText3Ds = function(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x,y,z)
	if onScreen then
		local factor = #text / 350
		SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry('STRING')
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x, _y)
		DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
	end
end

-- Core Thread Function
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in pairs(Config.MenuOpen) do
			local distance = Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z)
			if distance <= 1.5 then
				DrawText3Ds(v.x, v.y, v.z, "[E] to receive ~g~patch-notes.~s~")
				if IsControlJustPressed(0, 38) then
					TriggerEvent("Anim")
					TriggerEvent("PatchNotes")
				end
			end
		end		
	end
end)


RegisterNUICallback('close', function(data, cb)  
  PatchNotes()
  cb('closed')
end)

RegisterNetEvent("Anim")
AddEventHandler("Anim", function(inputText) 
    loadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 0.3, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end)

--[[RegisterCommand("patchnotes", function(source, args, raw)
	TriggerEvent("Anim")
	TriggerEvent("PatchNotes")
end, false)--]]
