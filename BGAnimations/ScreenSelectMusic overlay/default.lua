local function input(event)
	if event.DeviceInput.button == "DeviceButton_left mouse button" and event.type == "InputEventType_Release" then
		MESSAGEMAN:Broadcast("MouseLeftClick")
	elseif event.DeviceInput.button == "DeviceButton_right mouse button" and event.type == "InputEventType_Release" then
		MESSAGEMAN:Broadcast("MouseRightClick")
	end
	return false
end

local t =
	Def.ActorFrame {
	BeginCommand = function(self)
		local s = SCREENMAN:GetTopScreen()
		s:AddInputCallback(input)
	end
}

t[#t + 1] =
	Def.Actor {
	CodeMessageCommand = function(self, params)
		if params.Name == "AvatarShow" and getTabIndex() == 0 and not SCREENMAN:get_input_redirected(PLAYER_1) then
			SCREENMAN:AddNewScreenToTop("ScreenAvatarSwitch")
		end
	end
}

t[#t + 1] = LoadActor("../_frame")
t[#t + 1] = LoadActor("../_PlayerInfo")

t[#t + 1] =
	LoadFont("ZenithBold") .. {
		InitCommand=function(self)
			self:xy(SCREEN_WIDTH - 810, 11.5):zoom(.55):diffuse(Color.White)
			end,
		BeginCommand=function(self)
			self:settext("Pick a tune...")
		end
	}	
t[#t + 1] =
	LoadFont("ZenithBold") .. {
		InitCommand=function(self)
			self:xy(SCREEN_WIDTH - 8, 240):zoom(.55):diffuse(Color.Red)
			end,
		BeginCommand=function(self)
			self:settext("<")
		end
	}	

t[#t + 1] = LoadActor("currentsort.lua")
t[#t + 1] = LoadActor("../_cursor")
t[#t + 1] = LoadActor("../_halppls")
t[#t + 1] = LoadActor("currenttime")

GAMESTATE:UpdateDiscordMenu(
	GetPlayerOrMachineProfile(PLAYER_1):GetDisplayName() ..
		": " .. string.format("%5.2f", GetPlayerOrMachineProfile(PLAYER_1):GetPlayerRating())
)

return t
