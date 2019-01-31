local zX = 12
local zY = 6
-- local zTest = scale(idx,1,5,-12*2,12*2)
local t = Def.ActorFrame { FOV=90;
};
t[#t+1] = Def.Quad {
	InitCommand=cmd(zoomto,128+32,10);
	OnCommand=cmd(diffuse,Colors.Black;fadeleft,0.5;faderight,0.5;diffusealpha,0.75);
}
for idx, diff in pairs(Difficulty) do -- 0, Difficulty_Beginner
	t[#t+1] = Def.ActorFrame {
	Def.Quad {
		InitCommand=cmd(zoomto,zX,zY;diffuse,Colors.Difficulty[diff]);
		ShowCommand=cmd(stoptweening;linear,0.1;diffusealpha,1;y,0;);
		HideCommand=cmd(stoptweening;linear,0.1;diffusealpha,0.25;y,1;);
		BeginCommand=cmd(x,scale(idx,1,5,-12*3,12*3));

		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if not song then
				self:playcommand("Hide");
				return;
			end;
			local st = GAMESTATE:GetCurrentStyle():GetStepsType();
			local bHasStepsTypeAndDifficulty =
				song and song:HasStepsTypeAndDifficulty( st, diff );
--~ 			local difficulty = song:GetOneSteps( st, diff ):GetMeter();
			self:playcommand( bHasStepsTypeAndDifficulty and "Show" or "Hide" );
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
	Def.Quad {
		InitCommand=cmd(zoomto,zX-2,zY-2;diffuse,Colors.Difficulty[diff];diffusetopedge,ColorLightTone( Colors.Difficulty[diff] ) );
		ShowCommand=cmd(stoptweening;linear,0.1;diffusealpha,1;y,0;);
		HideCommand=cmd(stoptweening;linear,0.1;diffusealpha,0.25;y,1;);
		BeginCommand=cmd(x,scale(idx,1,5,-12*3,12*3));

		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if not song then
				self:playcommand("Hide");
				return;
			end;
			local st = GAMESTATE:GetCurrentStyle():GetStepsType()
			local bHasStepsTypeAndDifficulty =
				song and song:HasStepsTypeAndDifficulty( st, diff );
--~ 			local difficulty = song:GetOneSteps( st, diff ):GetMeter();
			self:playcommand( bHasStepsTypeAndDifficulty and "Show" or "Hide" );
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
	};
end

return t;
