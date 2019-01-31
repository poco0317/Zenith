return Def.ActorFrame {
	LoadFont("Common Normal") .. {
		Name="Main";
		Text="TEST1;";
		InitCommand=cmd(horizalign,left;vertalign,bottom;zoom,0.75;strokecolor,Color("Black");maxwidth,180);
	};
	LoadFont("Common Normal") .. {
		Name="Sub";
		Text="TEST2;";
		InitCommand=cmd(horizalign,left;vertalign,bottom;zoom,0.5;strokecolor,Color("Black");maxwidth,96*0.75);
	};
	
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand=function(self)
		local c = self:GetChildren();
		local curInfo = {
			Mode = nil,
			Main = nil,
			Sub = nil,
		};
		if GAMESTATE:GetCurrentSong() then
			curInfo.Mode = "Song";
			curInfo.Main = GAMESTATE:GetCurrentSong():GetTranslitFullTitle();
			curInfo.Sub = GAMESTATE:GetCurrentSong():GetTranslitArtist();
		elseif GAMESTATE:GetCurrentCourse() then
			curInfo.Mode = "Course";
			curInfo.Main = string.sub(GAMESTATE:GetCurrentCourse():GetCourseType(),12);
			curInfo.Sub = ( GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() == 1 ) and GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() .. " Stage" or GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() .. " Stages";
		else
			curInfo.Mode = nil;
			curInfo.Main = "";
			curInfo.Sub = "";
		end
		
		c.Main:settext(curInfo.Main );
		c.Sub:settext(curInfo.Sub);
		c.Sub:x(clamp(c.Main:GetWidth(),0,148) * 0.75 + 4);
		c.Sub:visible( (curInfo.Mode == "Course") );
	end;
};