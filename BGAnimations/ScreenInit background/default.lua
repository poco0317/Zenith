local t = Def.ActorFrame {}

math.random()

t[#t + 1] =
	Def.ActorFrame {
	InitCommand = function(self)
		self:Center()
	end,
	LoadActor("woop") ..
		{
			OnCommand = function(self)
				self:zoomto(SCREEN_WIDTH, 150):diffusealpha(0):linear(1):diffusealpha(1):sleep(1.75):linear(2):diffusealpha(0)
			end
		},
	Def.ActorFrame {
		OnCommand = function(self)
			self:playcommandonchildren("ChildrenOn")
		end,
		ChildrenOnCommand = function(self)
			self:diffusealpha(0):sleep(0.5):linear(0.5):diffusealpha(1)
		end,
		LoadFont("Common Normal") ..
			{
				Text = "Zenith",
				InitCommand = function(self)
					self:y(-24)
				end,
				OnCommand = function(self)
					self:sleep(1):linear(3):diffuse(color("#111111")):diffusealpha(0)
				end
			},
		LoadFont("Common Normal") ..
			{
				Text = "Created by SSC (edit by RyanGarsee)",
				InitCommand = function(self)
					self:y(16):zoom(0.75):maxwidth(SCREEN_WIDTH)
				end,
				OnCommand = function(self)
					self:sleep(1):linear(3):diffuse(color("#111111")):diffusealpha(0)
				end
			}
	}
}

return t
