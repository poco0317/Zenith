--Input event for mouse clicks
local function input(event)
	return false
end

local t =
	Def.ActorFrame {
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(input)
	end
}

t[#t + 1] = LoadActor("../_frame")
t[#t + 1] = LoadActor("../_NetPlayerInfo")
t[#t + 1] = LoadActor("currentsort")
t[#t + 1] = LoadActor("../_cursor")
t[#t + 1] = LoadActor("../_mouseselect")
t[#t + 1] = LoadActor("../_mousewheelscroll")
t[#t + 1] = LoadActor("currenttime")
t[#t + 1] = LoadActor("../_halppls")
t[#t + 1] = LoadActor("../_userlist")
t[#t + 1] = LoadActor("../_lobbyuserlist")

return t
