local active = true
local numericinputactive = false
local whee

local tabNames = {"General (1)", "MSD (2)", "Scores (3)", "Search (4)", "Profile (5)", "Filters (6)", "Goals (7)", "Packs (8)"} -- this probably should be in tabmanager.

local function input(event)
	if event.type ~= "InputEventType_Release" and active then
		if numericinputactive == false then
			if
				not (INPUTFILTER:IsBeingPressed("left ctrl") or INPUTFILTER:IsBeingPressed("right ctrl") or
					(SCREENMAN:GetTopScreen():GetName() ~= "ScreenSelectMusic" and
					 SCREENMAN:GetTopScreen():GetName() ~= "ScreenNetSelectMusic"))
			 then
				if event.DeviceInput.button == "DeviceButton_8" then
					setTabIndex(8)
					MESSAGEMAN:Broadcast("TabChanged")
				else
					for i = 1, #tabNames do
						local numpad = event.DeviceInput.button == "DeviceButton_KP "..event.char	-- explicitly ignore numpad inputs for tab swapping (doesn't care about numlock) -mina
						if not numpad and event.char and tonumber(event.char) and tonumber(event.char) == i then
							setTabIndex(i - 1)
							MESSAGEMAN:Broadcast("TabChanged")
						end
					end
				end
			end
		end
	end
	return false
end
local t =
	Def.ActorFrame {
	InitCommand=function(self)
	self:xy(SCREEN_CENTER_X + 499, SCREEN_CENTER_Y - 122.5):addrotationz(90)
	end,
	BeginCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(MPinput)
		SCREENMAN:GetTopScreen():AddInputCallback(input)
		resetTabIndex()
	end,
	NumericInputActiveMessageCommand = function(self)
		numericinputactive = true
	end,
	NumericInputEndedMessageCommand = function(self)
		numericinputactive = false
	end
}

local frameWidth = 32
local frameX = frameWidth - 16
local frameY = SCREEN_HEIGHT - 60

function tabs(index)
	local t =
		Def.ActorFrame {
		Name = "Tab" .. index,
		InitCommand = function(self)
			self:xy(frameX + ((index - 1) * frameWidth), frameY)
		end,
		BeginCommand = function(self)
			self:queuecommand("Set")
		end,
		SetCommand = function(self)
			self:finishtweening()
			self:linear(0.1)
			--show tab if it's the currently selected one
			if getTabIndex() == index - 1 then
				self:y(frameY)
				self:diffusealpha(1)
			else -- otherwise "Hide" them
				self:y(frameY)
				self:diffusealpha(0.65)
			end
		end,
		TabChangedMessageCommand = function(self)
			self:queuecommand("Set")
		end
	}

	t[#t + 1] =
		Def.Quad {
		Name = "TabBG",
		InitCommand = function(self)
			self:y(2):valign(0):zoomto(frameWidth, 20):diffusecolor(getMainColor("frames")):diffusealpha(1)
		end,
		MouseLeftClickMessageCommand = function(self)
			if isOver(self) then
				setTabIndex(index - 1)
				MESSAGEMAN:Broadcast("TabChanged")
			end
		end
	}

	t[#t + 1] =
		LoadFont("ZenithBold") ..
		{
			InitCommand = function(self)
				self:y(7):valign(0):zoom(0.4):diffuse(getMainColor("positive")):maxwidth(frameWidth * 2)
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settext(tabNames[index])
				if isTabEnabled(index) then
					if index == 6 and FILTERMAN:AnyActiveFilter() then
						self:diffuse(color("#cc2929"))
					else
						self:diffuse(getMainColor("positive"))
					end
				else
					self:diffuse(color("#666666"))
				end
			end
		}
	return t
end

--Make tabs
for i = 1, #tabNames do
	t[#t + 1] = tabs(i)
end

return t
