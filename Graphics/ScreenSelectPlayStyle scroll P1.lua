local gc = Var "GameCommand";
local tStrings = {
	HeaderText	=	THEME:GetString( Var "LoadingScreen", gc:GetName() .. "Header" ),
	BodyText	=	THEME:GetString( Var "LoadingScreen", gc:GetName() .. "Body" ),
};
local tInfo = {
	Songs 		= SONGMAN:GetNumSongs();
	SongGroups 	= SONGMAN:GetNumSongGroups();
	SongAdd		= SONGMAN:GetNumAdditionalSongs();
	Courses		= SONGMAN:GetNumCourses();
	CourseGroups= SONGMAN:GetNumCourseGroups();
	CourseAdd	= SONGMAN:GetNumAdditionalCourses();
}
local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	GainFocusCommand=cmd(visible,true);
	LoseFocusCommand=cmd(visible,false);
	LoadFont("_venacti","Bold 24px") .. {
		Text=tStrings['HeaderText'];
		InitCommand=cmd(horizalign,left;vertalign,bottom;x,-256+8;y,-40+10);
		GainFocusCommand=cmd(finishtweening;diffuse,ColorLightTone(Colors.Red);diffusetopedge,Colors.Red;strokecolor,Colors.Outline;diffusealpha,0;addx,-16;decelerate,0.35;addx,16;diffusealpha,1);
	};
	Def.Quad {
		InitCommand=cmd(horizalign,left;vertalign,bottom;x,-256+8;y,-40+14;zoomto,(256-8)*2,2);
		GainFocusCommand=cmd(finishtweening;diffuse,Colors.Red;diffusealpha,0;decelerate,0.35;diffusealpha,1;faderight,1);
	};
	LoadFont("Common Normal") .. {
		Text=tStrings['BodyText'];
		InitCommand=cmd(horizalign,left;vertalign,top;x,-256+8;y,-40+20;zoom,0.5;wrapwidthpixels,1024-32);
		GainFocusCommand=cmd(finishtweening;strokecolor,Colors.Outline;diffusealpha,0;addx,-16;sleep,0.35;decelerate,0.35*0.5;addx,16;diffusealpha,1);
	};
};
t[#t+1] = Def.ActorFrame {
	GainFocusCommand=cmd(visible,true);
	LoseFocusCommand=cmd(visible,false);
	LoadFont("Common","Normal") .. {
		Text=gc:GetName() == "Normal" and ( tInfo['Songs'] .. " Installed Songs [+" .. tInfo['SongAdd'] .. " Added] \n" .. tInfo['SongGroups'] .. " Groups" ) or ( tInfo['Courses'] .. " Installed Courses [+" .. tInfo['CourseAdd'] .. " Added] \n" .. tInfo['CourseGroups'] .. " Groups" );
		InitCommand=cmd(horizalign,left;vertalign,bottom;x,-256+8+16;y,40;zoom,0.5);
		GainFocusCommand=cmd(finishtweening;strokecolor,Colors.Outline;diffusealpha,0;addx,-16;sleep,0.35;decelerate,0.35*0.75;addx,16;diffusealpha,1);
	};
};
return t