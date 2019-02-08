local function input(event) -- for update button
	if event.type ~= "InputEventType_Release" then
		if event.DeviceInput.button == "DeviceButton_left mouse button" then
			MESSAGEMAN:Broadcast("MouseLeftClick")
		elseif event.DeviceInput.button == "DeviceButton_right mouse button" then
			MESSAGEMAN:Broadcast("MouseRightClick")
		end
	end
	return false
end

local t =
	Def.ActorFrame {
	FOV=90;
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X):y(SCREEN_CENTER_Y-20.5)
	end;
	OnCommand = function(self)
		SCREENMAN:GetTopScreen():AddInputCallback(input)
		self:queuecommand("DelayedOn")
	end;
	LoadActor("_background") .. {
		InitCommand=function(self)
			self:zoomtowidth(SCREEN_WIDTH)
		end;
		DelayedOnCommand=function(self)
			self:shadowlength(1):diffusealpha(0):sleep(2.5):linear(0.125):diffusealpha(1)
		end;
	};
	Def.ActorFrame {
		DelayedOnCommand=function(self)
			self:z(-256):zoom(0):rotationz(360):rotationy(360):sleep(0.35):decelerate(2):rotationz(0):rotationy(0):z(0):zoom(1)
		end;
		LoadActor("_bottom rail") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:bounce():effectmagnitude(0,20,0):effecttiming(0.75,0,0.25,0):diffuse(Color("Black")):diffusealpha(0.5)
			end;
		};
		LoadActor("_bottom rail") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:bounce():effectmagnitude(0,12,0):effecttiming(0.75,0,0.25,0):diffuse(Color("Red")):diffusealpha(0.5)
			end;
		};
		LoadActor("_bottom rail") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:bounce():effectmagnitude(0,4,0):effecttiming(0.75,0,0.25,0)
			end;
		};
		LoadActor("_top rail") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:bounce():effectmagnitude(0,-20,0):effecttiming(0.75,0,0.25,0):diffuse(Color("Black")):diffusealpha(0.5)
			end;
		};
		LoadActor("_top rail") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:bounce():effectmagnitude(0,-12,0):effecttiming(0.75,0,0.25,0):diffuse(Color("Red")):diffusealpha(0.5)
			end;
		};
		LoadActor("_top rail") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:bounce():effectmagnitude(0,-4,0):effecttiming(0.75,0,0.25,0)
			end;
		};
		LoadActor("_accent") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:glowramp()
			end;
		};
		LoadActor("_text") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:zoomx(1.075):zoomy(1):diffusealpha(0.5):diffuseramp():effectcolor1(color("1,1,1,0")):effectcolor2(color("1,1,1,1")):effectclock('beat'):effectperiod(2)
			end;
		};
		LoadActor("_text") .. {
			InitCommand=function(self)
				self:effectclock('beat'):z(0)
			end;
			OnCommand=function(self)
				self:glowramp()
			end;
		};
	};
}

local frameX = THEME:GetMetric("ScreenTitleMenu", "ScrollerX")
local frameY = THEME:GetMetric("ScreenTitleMenu", "ScrollerY") - 100

t[#t + 1] =
	Def.Quad{
		InitCommand=function(self)
			self:zoomto(SCREEN_CENTER_X-555,SCREEN_BOTTOM-100):diffuse(Color.Black)
		end,
		OnCommand=function(self)
		self:xy(SCREEN_CENTER_X-800,270)
		end,
	}
	
t[#t + 1] =
	Def.Quad{
		InitCommand=function(self)
			self:zoomto(200,5):diffuse(Color.Red)
		end,
		OnCommand=function(self)
		self:xy(SCREEN_CENTER_X-836,79)
		end,
	}

t[#t + 1] =
	Def.Quad{
		InitCommand=function(self)
			self:zoomto(5,200):diffuse(Color.Red)
		end,
		OnCommand=function(self)
		self:xy(SCREEN_CENTER_X-736,176.5)
		end,
	}

-- lazy game update button -mina
local gameneedsupdating = false
local buttons = {x = -305, y = SCREEN_HEIGHT/2 + 5, width = 140, height = 36, fontScale = 0.3, color = getMainColor("frames")}
t[#t + 1] =
	Def.Quad {
	InitCommand = function(self)
		self:xy(buttons.x, buttons.y):zoomto(buttons.width, buttons.height):halign(0)
		self:diffuse(buttons.color):diffusealpha(0)
		local latest = tonumber((DLMAN:GetLastVersion():gsub("[.]", "", 1)))
		local current = tonumber((GAMESTATE:GetEtternaVersion():gsub("[.]", "", 1)))
		if latest and latest > current then
			gameneedsupdating = true
		end
	end,
	OnCommand = function(self)
		if gameneedsupdating then
			self:diffusealpha(1)
		end
	end,
	MouseLeftClickMessageCommand = function(self)
		if isOver(self) and gameneedsupdating then
			GAMESTATE:ApplyGameCommand("urlnoexit,https://github.com/etternagame/etterna/releases;text,GitHub")
		end
	end
}

t[#t + 1] =
	LoadFont("Common Large") ..
	{
		OnCommand = function(self)
			self:xy(buttons.x, buttons.y):halign(0):zoom(buttons.fontScale):diffuse(getMainColor("positive"))
			if gameneedsupdating then
				self:settext("Update Available\nClick to Update")
			else
				self:settext("")
			end
		end
	}
	
t[#t + 1] =
	Def.Sound{
		File="Bloom Nobly (loop).ogg",
			
		OnCommand=function(self)
			self:play()
		end,
	}

function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

local transformF = THEME:GetMetric("ScreenTitleMenu", "ScrollerTransform")
local scrollerX = THEME:GetMetric("ScreenTitleMenu", "ScrollerX")
local scrollerY = THEME:GetMetric("ScreenTitleMenu", "ScrollerY")
local scrollerChoices = THEME:GetMetric("ScreenTitleMenu", "ChoiceNames")
local _, count = string.gsub(scrollerChoices, "%,", "")
local choices = mysplit(scrollerChoices, ",")
local choiceCount = count + 1
local i
for i = 1, choiceCount do
	t[#t + 1] =
		Def.Quad {
		OnCommand = function(self)
			self:x(scrollerX - 30):zoomto(140, 16)
			self:halign(1)
			transformF(self, 0, i, choiceCount)
			self:addy(150)
			self:diffusealpha(0)
		end,
		MouseLeftClickMessageCommand = function(self)
			if (isOver(self)) then
				SCREENMAN:GetTopScreen():playcommand("MadeChoicePlayer_1")
				SCREENMAN:GetTopScreen():playcommand("Choose")
				if choices[i] == "Multi" or choices[i] == "GameStart" then
					GAMESTATE:JoinPlayer(1)
				end
				GAMESTATE:ApplyGameCommand(THEME:GetMetric("ScreenTitleMenu", "Choice" .. choices[i]))
			end
		end
	}
end

return t
