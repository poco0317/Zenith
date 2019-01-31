local t = Def.ActorFrame {}
t[#t + 1] = LoadActor("../_frame")
t[#t + 1] = LoadActor("../_PlayerInfo")
t[#t + 1] = LoadActor("currenttime")

----------------------------------------------------------------------------------------------------

--Grade calculation and sprites
local score = SCOREMAN:GetMostRecentScore()
local grade = score:GetWifeGrade()
t[#t + 1] = Def.Sprite{
    Texture="Thanks_Nick12 8x1",
    InitCommand = function(self)
	self:xy(SCREEN_CENTER_X + 14, SCREEN_CENTER_Y - 83.5):zoom(0.20)
        local frame	
    if grade == "Grade_Tier01" then
        --AAAA graphic
    frame = 0
    elseif grade == "Grade_Tier02" then
        --AAA graphic
    frame = 1
    elseif grade == "Grade_Tier03" then
        --AA graphic
    frame = 2
	elseif grade == "Grade_Tier04" then
		--A graphic
	frame = 3
    elseif grade == "Grade_Tier05" then
        --B graphic
    frame = 4
    elseif grade == "Grade_Tier06" then
        --C graphic
    frame = 5
    elseif grade == "Grade_Tier07" then
        --D graphic
    frame = 6
    else
        --F graphic
    frame = 7
    end
        self:SetStateProperties{{Frame = frame, Delay=0}}
    end
}

--------------------------------------------------------------------------------------------------------------------------

--Group folder name
local frameWidth = 280
local frameHeight = 20
local frameX = SCREEN_WIDTH - 5
local frameY = 15

t[#t + 1] = LoadActor("../_cursor")

return t
