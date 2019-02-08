-- Old avatar actor frame.. renamed since much more will be placed here (hopefully?)
local t =
	Def.ActorFrame {
	Name = "PlayerAvatar"
}

local profile

local profileName = "No Profile"
local playCount = 0
local playTime = 0
local noteCount = 0
local numfaves = 0
local AvatarX = 0
local AvatarY = SCREEN_HEIGHT - 50
local playerRating = 0

local setnewdisplayname = function(answer)
	profile:RenameProfile(answer)
	profileName = answer
	MESSAGEMAN:Broadcast("ProfileRenamed", {doot = answer})
end

local function highlight(self)
	self:GetChild("refreshbutton"):queuecommand("Highlight")
end

local function highlightIfOver(self)
	if isOver(self) then
		self:diffusealpha(0.6)
	else
		self:diffusealpha(1)
	end
end

t[#t + 1] =
	Def.Actor {
	BeginCommand = function(self)
		self:queuecommand("Set")
	end,
	SetCommand = function(self)
		profile = GetPlayerOrMachineProfile(PLAYER_1)
		profileName = profile:GetDisplayName()
		playCount = profile:GetTotalNumSongsPlayed()
		playTime = profile:GetTotalSessionSeconds()
		noteCount = profile:GetTotalTapsAndHolds()
		playerRating = profile:GetPlayerRating()
	end
}

t[#t + 1] =
	Def.Sprite {
	Texture="profilecontainer.png",
	InitCommand = function(self)
		self:xy(SCREEN_CENTER_X - 20.8, 0):halign(0):valign(0):zoomto(51.5,58)
	end
}

t[#t + 1] =
	Def.ActorFrame {
	Name = "Avatar" .. PLAYER_1,
	BeginCommand = function(self)
		self:queuecommand("Set")
		self:SetUpdateFunction(highlight)
	end,
	SetCommand = function(self)
		if profile == nil then
			self:visible(false)
		else
			self:visible(true)
		end
	end,
	Def.Sprite {
		Name = "Image",
		InitCommand = function(self)
			self:visible(true):halign(0):valign(0):xy(SCREEN_CENTER_X - 20, AvatarY - 430)
		end,
		BeginCommand = function(self)
			self:queuecommand("ModifyAvatar")
		end,
		ModifyAvatarCommand = function(self)
			self:finishtweening()
			self:Load(getAvatarPath(PLAYER_1))
			self:zoomto(50, 50)
		end,
		MouseLeftClickMessageCommand = function(self)
			if isOver(self) and not SCREENMAN:get_input_redirected(PLAYER_1) then
				local top = SCREENMAN:GetTopScreen()
				SCREENMAN:AddNewScreenToTop("ScreenAvatarSwitch")
			end
		end
	},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(AvatarX + 3, AvatarY + 36.5):maxwidth(222):halign(0):zoom(0.62):diffuse(getMainColor("positive"))
			end,
			SetCommand = function(self)
				self:settextf("%s: %5.2f", profileName, playerRating)
				if profileName == "Default Profile" then
					easyInputStringWithFunction(
						"Choose a profile display name\nClicking your name will allow you to change it:",
						64,
						false,
						setnewdisplayname
					)
				end
			end,
			MouseLeftClickMessageCommand = function(self)
				if isOver(self) and not SCREENMAN:get_input_redirected(PLAYER_1) then
					easyInputStringWithFunction("Choose new profile display name:", 64, false, setnewdisplayname)
				end
			end,
			ProfileRenamedMessageCommand = function(self, params)
				self:settextf("%s: %5.2f", params.doot, playerRating)
			end
		},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(SCREEN_CENTER_X, AvatarY + 29):halign(0.5):zoom(0.3):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				if DLMAN:IsLoggedIn() then
					self:queuecommand("Login")
				else
					self:queuecommand("LogOut")
				end
			end,
			LogOutMessageCommand = function(self)
				if SCREENMAN:GetTopScreen():GetName() == "ScreenSelectMusic" then
					self:settext("Click to login")
				else
					self:settextf("Not logged in")
				end
			end,
			LoginMessageCommand = function(self) --this seems a little clunky -mina
				if SCREENMAN:GetTopScreen() and SCREENMAN:GetTopScreen():GetName() == "ScreenSelectMusic" then
					self:settextf(
						"Logged in as %s (%5.2f: #%i) \n%s",
						DLMAN:GetUsername(),
						DLMAN:GetSkillsetRating("Overall"),
						DLMAN:GetSkillsetRank(ms.SkillSets[1]),
						"Click to Logout"
					)
				else
					self:settextf(
						"Logged in as %s (%5.2f: #%i)",
						DLMAN:GetUsername(),
						DLMAN:GetSkillsetRating("Overall"),
						DLMAN:GetSkillsetRank(ms.SkillSets[1])
					)
				end
			end,
			OnlineUpdateMessageCommand = function(self)
				self:queuecommand("Set")
			end
		},
	Def.Quad {
		InitCommand = function(self)
			self:xy(SCREEN_CENTER_X, AvatarY + 20):halign(0.5):zoomto(100, 30):diffusealpha(0)
		end,
		LoginFailedMessageCommand = function(self)
			ms.ok("Login failed!")
		end,
		LoginMessageCommand = function(self)
			playerConfig:get_data(pn_to_profile_slot(PLAYER_1)).UserName = DLMAN:GetUsername()
			playerConfig:get_data(pn_to_profile_slot(PLAYER_1)).PasswordToken = DLMAN:GetToken()
			playerConfig:set_dirty(pn_to_profile_slot(PLAYER_1))
			playerConfig:save(pn_to_profile_slot(PLAYER_1))
			ms.ok("Succesfully logged in")
		end,
		MouseLeftClickMessageCommand = function(self)
			if isOver(self) and not SCREENMAN:get_input_redirected(PLAYER_1) then
				if not DLMAN:IsLoggedIn() then
					username = function(answer)
						user = answer
					end
					password = function(answer)
						pass = answer
						DLMAN:Login(user, pass)
					end
					easyInputStringWithFunction("Password:", 50, true, password)
					easyInputStringWithFunction("Username:", 50, false, username)
				else
					playerConfig:get_data(pn_to_profile_slot(PLAYER_1)).UserName = ""
					playerConfig:get_data(pn_to_profile_slot(PLAYER_1)).PasswordToken = ""
					playerConfig:set_dirty(pn_to_profile_slot(PLAYER_1))
					playerConfig:save(pn_to_profile_slot(PLAYER_1))
					DLMAN:Logout()
				end
			end
		end
	},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(AvatarX + 95, AvatarY + 32):halign(0):zoom(0.35):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settext(" ")
			end
		},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(AvatarX + 133, AvatarY + 44):halign(0):zoom(0.35):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settext(" ")
			end
		},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(AvatarX + 4, AvatarY + 44):halign(0):zoom(0.35):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				local time = SecondsToHHMMSS(playTime)
				self:settextf(" ")
			end
		},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(SCREEN_CENTER_X - 244, AvatarY + 36):halign(0.5):zoom(0.65):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settext("| Judge: " .. GetTimingDifficulty())
			end
		},
			LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(SCREEN_CENTER_X - 174, AvatarY + 36):halign(0.5):zoom(0.65):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settext("| Life: " .. GetLifeDifficulty())
			end
		},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(SCREEN_WIDTH - 168, AvatarY + 44):halign(1):zoom(0.35):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settext("Theme Version: 1.3 (r0095)")
			end
		},
	LoadFont("Common Normal") .. {
		Name = "refreshbutton",
			InitCommand = function(self)
				self:xy(SCREEN_WIDTH - 5, AvatarY + 32):halign(1):zoom(0.35):diffuse(getMainColor("positive"))
				
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settextf("(Refresh Songs)")
			end,
			HighlightCommand=function(self)
				highlightIfOver(self)
			end,
			MouseLeftClickMessageCommand=function(self)
				if isOver(self) then
					SONGMAN:DifferentialReload()
				end
			end
		},
	LoadFont("Common Normal") ..
		{
			InitCommand = function(self)
				self:xy(SCREEN_WIDTH - 85, AvatarY + 32):halign(1):zoom(0.35):diffuse(getMainColor("positive"))
			end,
			BeginCommand = function(self)
				self:queuecommand("Set")
			end,
			SetCommand = function(self)
				self:settextf("Songs Loaded: %i", SONGMAN:GetNumSongs())
			end,
			DFRFinishedMessageCommand = function(self)
				self:queuecommand("Set")
			end
		}
}

local function Update(self)
	t.InitCommand = function(self)
		self:SetUpdateFunction(Update)
	end
	if getAvatarUpdateStatus() then
		self:GetChild("Avatar" .. PLAYER_1):GetChild("Image"):queuecommand("ModifyAvatar")
		setAvatarUpdateStatus(PLAYER_1, false)
	end
end
t.InitCommand = function(self)
	self:SetUpdateFunction(Update)
end

return t
