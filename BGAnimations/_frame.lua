local t = Def.ActorFrame {}

t[#t + 1] =	Def.Sprite {
	Texture="framebottom.png",
	InitCommand = function(self)
		self:xy(0, SCREEN_BOTTOM-50):halign(0):valign(0):zoomto(854,56)
	end
}

t[#t + 1] = Def.Sprite {
	Texture="framebottomcover.png",
	InitCommand = function(self)
		self:xy(0, SCREEN_BOTTOM-34):halign(0):valign(0):zoomto(854,34)
	end
}

t[#t + 1] = Def.Sprite {
	Texture="frametop.png",
	InitCommand = function(self)
		self:xy(0, SCREEN_TOP):halign(0):valign(0):zoomto(854,80)
	end
}

t[#t + 1] = Def.Sprite {
	Texture="frametopcover.png",
	InitCommand = function(self)
		self:xy(0, SCREEN_TOP):halign(0):valign(0):zoomto(854,34)
	end
}
	
return t
