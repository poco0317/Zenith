local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  FOV=90;
  InitCommand=function(self)
  	self:Center()
  end;
	LoadActor("074_JumpBack_NTSC_DV") .. {
		InitCommand=function(self)
			self:scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT)
		end;
		OnCommand=function(self)
			self:diffuse(Color("Red")):diffusealpha(0.5):rate(1.3)
		end;
	};
	LoadActor("_bg") .. {
		InitCommand=function(self)
			self:scaletoclipped(SCREEN_WIDTH+1,SCREEN_HEIGHT)
		end;
		OnCommand=function(self)
			self:blend('BlendMode_Add')
		end;
	};
	LoadActor("_grid") .. {
		InitCommand=function(self)
			self:customtexturerect(0,0,(SCREEN_WIDTH+1)/4,SCREEN_HEIGHT/4)
		end;
		OnCommand=function(self)
			self:zoomto(SCREEN_WIDTH+1,SCREEN_HEIGHT):diffuse(Color("Black"))
			self:effectcolor2(Color.Alpha(Color("Black"),0.25)):effectcolor1(Color.Alpha(Color("Black"),0.125));
			self:effectperiod(8);
		end;
	};
	Def.Quad {
		InitCommand=function(self)
			self:zoomto(SCREEN_WIDTH+1,SCREEN_HEIGHT)
		end;
		OnCommand=function(self)
			self:diffuse(color("0,0,0,0.25"))
		end;
	};
};

t[#t+1] = Def.ActorFrame {
	FOV=90;
	InitCommand=function(self)
		self:x(SCREEN_CENTER_X+256):y(SCREEN_CENTER_Y):z(0):rotationz(30):rotationy(30):rotationx(-32):wag():effectmagnitude(8,8,0):effectperiod(8)
	end;
	LoadActor("_grain") .. {
		InitCommand=function(self)
			self:zoomto(1024,SCREEN_HEIGHT*4):customtexturerect(0,0,1024/256,(SCREEN_HEIGHT*4)/256)
		end;
		OnCommand=function(self)
			self:texcoordvelocity(0,0.5):z(-32):diffuse(Color("Red")):blend('BlendMode_Add'):fadeleft(0.3)
		end;
	};
	LoadActor("_block") .. {
		InitCommand=function(self)
			self:zoomto(1024,SCREEN_HEIGHT*4):customtexturerect(0,0,1024/256,(SCREEN_HEIGHT*4)/256)
		end;
		OnCommand=function(self)
			self:texcoordvelocity(0,0.25):diffuse(Color("Red")):diffusealpha(0.75):fadeleft(0.3)
		end;
	};
	LoadActor("_data") .. {
		InitCommand=function(self)
			self:zoomto(1024,SCREEN_HEIGHT*4):customtexturerect(0,0,1024/256,(SCREEN_HEIGHT*4)/256)
		end;
		OnCommand=function(self)
			self:texcoordvelocity(0.125,0.25):z(32):diffuse(Color("Red")):blend('BlendMode_Add'):fadeleft(0.3)
		end;
	};
	LoadActor("_stripe") .. {
		InitCommand=function(self)
			self:zoomto(2056,SCREEN_HEIGHT*4):customtexturerect(0,0,2056/64,(SCREEN_HEIGHT*4)/64)
		end;
		OnCommand=function(self)
			self:skewx(1):texcoordvelocity(0.125,0.25):z(32):diffuse(ColorMidTone( Color("Red") )):fadeleft(0.5):faderight(0.5):diffusebottomedge(Color.Alpha( Color("Red"), 0 ))
		end;
	};
};

return t;
