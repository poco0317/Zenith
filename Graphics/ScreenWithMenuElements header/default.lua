local sScreen = "ScreenWithMenuElements Header";

return Def.ActorFrame {
	LoadActor("header fill") .. {
		Name="Fill";
		InitCommand=function(self)
			ActorUtil.LoadAllCommandsAndSetXY(self,sScreen); 
		end;
-- 		InitCommand=cmd(vertalign,bottom);
	};
	LoadActor("header cover") .. {
		Name="Cover";
		InitCommand=function(self)
			ActorUtil.LoadAllCommandsAndSetXY(self,sScreen); 
		end;
	};
	LoadFont("Common Normal") .. {
		Name="Text";
		Text=Screen.String("HeaderText");
		InitCommand=function(self)
			ActorUtil.LoadAllCommandsAndSetXY(self,sScreen); 
		end;
		UpdateScreenHeaderMessageCommand=function(self,param)
			self:settext(param.Header);
		end;
	};
};