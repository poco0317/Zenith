local sScreen = "ScreenWithMenuElements Footer";
			
return Def.ActorFrame {
	LoadActor("footer fill") .. {
		Name="Fill";
		InitCommand=function(self)
			ActorUtil.LoadAllCommandsAndSetXY(self,sScreen); 
		end;
-- 		InitCommand=cmd(vertalign,bottom);
	};
	LoadActor("footer cover") .. {
		Name="Cover";
		InitCommand=function(self)
			ActorUtil.LoadAllCommandsAndSetXY(self,sScreen); 
		end;
	};
};