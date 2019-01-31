local sString;
local t = Def.ActorFrame{
	LoadFont("Common normal")..{
		InitCommand=cmd(horizalign,right;vertalign,bottom;shadowlength,1;uppercase,true;zoom,0.5;maxwidth,128+8;diffusealpha,0;sleep,0.35;linear,0.35*0.5;diffusealpha,1);
		SetMessageCommand=function(self,param)
			sString = THEME:GetString("StepsDisplay StepsType",ToEnumShortString(param.StepsType));
			if param.Steps and param.Steps:IsAutogen() then
				self:diffuse(Color("Green"));
				self:diffusetopedge(ColorLightTone( Color("Green") ));
			else
				self:diffuse(Color("White"));
			end;
			(cmd(finishtweening;diffusealpha,0.25;linear,0.1;diffusealpha,1))(self);
			self:settext( sString );
		end;
	};
	-- argh this isn't working as nicely as I would've hoped...
	--[[
	Def.Sprite{
		SetMessageCommand=function(self,param)
			self:Load( THEME:GetPathG("","_StepsType/"..ToEnumShortString(param.StepsType)) );
			self:diffusealpha(0.5);
		end;
	};
	--]]
};

return t;