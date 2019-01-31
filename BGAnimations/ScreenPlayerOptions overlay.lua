local t = Def.ActorFrame {}
local topFrameHeight = 35
local bottomFrameHeight = 54
local borderWidth = 4

local t =
	Def.ActorFrame {
	Name = "PlayerAvatar"
}

local profileP1

local profileNameP1 = "No Profile"
local playCountP1 = 0
local playTimeP1 = 0
local noteCountP1 = 0

local AvatarXP1 = 5
local AvatarYP1 = 50

local bpms = {}
if GAMESTATE:GetCurrentSong() then
	bpms = GAMESTATE:GetCurrentSong():GetDisplayBpms()
	bpms[1] = math.round(bpms[1])
	bpms[2] = math.round(bpms[2])
end

-- P1 Avatar gone

t[#t + 1] =
	Def.Actor {
	BeginCommand = function(self)
		self:queuecommand("Set")
	end,
	SetCommand = function(self)
		if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
			profileP1 = GetPlayerOrMachineProfile(PLAYER_1)
			if profileP1 ~= nil then
				profileNameP1 = profileP1:GetDisplayName()
				playCountP1 = profileP1:GetTotalNumSongsPlayed()
				playTimeP1 = profileP1:GetTotalSessionSeconds()
				noteCountP1 = profileP1:GetTotalTapsAndHolds()
			else
				profileNameP1 = "No Profile"
				playCountP1 = 0
				playTimeP1 = 0
				noteCountP1 = 0
			end
		else
			profileNameP1 = "No Profile"
			playCountP1 = 0
			playTimeP1 = 0
			noteCountP1 = 0
		end
	end
}

--Frames
t[#t + 1] =
	Def.Quad {
	InitCommand = function(self)
		self:xy(0, 0):halign(0):valign(0):zoomto(SCREEN_WIDTH, topFrameHeight):diffuse(color("#000000"))
	end
}
t[#t + 1] =
	Def.Quad {
	InitCommand = function(self)
		self:xy(0, topFrameHeight):halign(0):valign(1):zoomto(SCREEN_WIDTH, borderWidth):diffuse(getMainColor("highlight")):diffusealpha(
			0.5
		)
	end
}

t[#t + 1] =
	LoadFont("Common Large") ..
	{
		InitCommand = function(self)
			self:xy(5, 32):halign(0):valign(1):zoom(0.55):diffuse(getMainColor("positive")):settext("Player Options:")
		end
	}

local NSPreviewSize = 0.5
local NSPreviewX = 20
local NSPreviewY = 125
local NSPreviewXSpan = 35
local NSPreviewReceptorY = -30
local OptionRowHeight = 35
local NoteskinRow = 0

function NSkinPreviewWrapper(dir, ele)
	return Def.ActorFrame {
		InitCommand = function(self)
			self:zoom(NSPreviewSize)
		end,
		LoadNSkinPreview("Get", dir, ele, PLAYER_1)
	}
end
t[#t + 1] =
	Def.ActorFrame {
	OnCommand = function(self)
		self:xy(NSPreviewX, NSPreviewY)
		for i = 0, SCREENMAN:GetTopScreen():GetNumRows() - 1 do
			if SCREENMAN:GetTopScreen():GetOptionRow(i) and SCREENMAN:GetTopScreen():GetOptionRow(i):GetName() == "NoteSkins" then
				NoteskinRow = i
			end
		end
		self:SetUpdateFunction(
			function(self)
				local row = SCREENMAN:GetTopScreen():GetCurrentRowIndex(PLAYER_1)
				local pos = 0
				if row > 4 then
					pos =
						NSPreviewY + NoteskinRow * OptionRowHeight -
						(SCREENMAN:GetTopScreen():GetCurrentRowIndex(PLAYER_1) - 4) * OptionRowHeight
				else
					pos = NSPreviewY + NoteskinRow * OptionRowHeight
				end
				self:y(pos)
				self:visible(NoteskinRow - row > -5 and NoteskinRow - row < 7)
			end
		)
	end,
	Def.ActorFrame {
		NSkinPreviewWrapper("Left", "Tap Note")
	},
	Def.ActorFrame {
		InitCommand = function(self)
			self:y(NSPreviewReceptorY)
		end,
		NSkinPreviewWrapper("Left", "Receptor")
	}
}
if GetScreenAspectRatio() > 1.7 then
	t[#t][#(t[#t]) + 1] =
		Def.ActorFrame {
		Def.ActorFrame {
			InitCommand = function(self)
				self:x(NSPreviewXSpan * 1)
			end,
			NSkinPreviewWrapper("Down", "Tap Note")
		},
		Def.ActorFrame {
			InitCommand = function(self)
				self:x(NSPreviewXSpan * 1):y(NSPreviewReceptorY)
			end,
			NSkinPreviewWrapper("Down", "Receptor")
		},
		Def.ActorFrame {
			InitCommand = function(self)
				self:x(NSPreviewXSpan * 2)
			end,
			NSkinPreviewWrapper("Up", "Tap Note")
		},
		Def.ActorFrame {
			InitCommand = function(self)
				self:x(NSPreviewXSpan * 2):y(NSPreviewReceptorY)
			end,
			NSkinPreviewWrapper("Up", "Receptor")
		},
		Def.ActorFrame {
			InitCommand = function(self)
				self:x(NSPreviewXSpan * 3)
			end,
			NSkinPreviewWrapper("Right", "Tap Note")
		},
		Def.ActorFrame {
			InitCommand = function(self)
				self:x(NSPreviewXSpan * 3):y(NSPreviewReceptorY)
			end,
			NSkinPreviewWrapper("Right", "Receptor")
		}
	}
end
return t
