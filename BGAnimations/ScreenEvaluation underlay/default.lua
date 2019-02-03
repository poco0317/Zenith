local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  FOV=90;
  InitCommand=self(Center);

	Def.Sprite {
		OnCommand=function(self)
			if GAMESTATE:GetCurrentSong() then
				self:LoadBackground( GAMESTATE:GetCurrentSong():GetBackgroundPath() );
				self:scaletoclipped( SCREEN_WIDTH+1,SCREEN_HEIGHT );
				(self(diffusealpha,0;linear,1;diffusealpha,0.75))(self);
			else
				self:visible(false);
			end
		end;
		OffCommand=cmd(linear,1;diffusealpha,0);
	};
};

return t;