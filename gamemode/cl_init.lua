include( "shared.lua" )

include( "cl_set_team.lua" )
--include( "cl_hud.lua" )

DEFINE_BASECLASS( "gamemode_base" )

local COLOR_WHITE = Color(255, 255, 255)


--[[---------------------------------------------------------
	Desc: Hides default join and leave messages in chat.
-----------------------------------------------------------]]
hook.Add( "ChatText", "hide_joinleave", function( index, name, text, typ )
	if ( typ == "joinleave" ) then return true end
end )

local function ScreenScale( num )
	return math.Clamp(ScrH() / 1080, 0.6, 1) * num *1.29
end

surface.CreateFont( "TheDefaultSettings", {
	font = "Arial", 
	size = ScreenScale(56), 
	weight = 1000, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

surface.CreateFont( "TheDefaultSettings1.5", {
	font = "Arial", 
	size = ScreenScale(45), 
	weight = 1000, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

surface.CreateFont( "TheDefaultSettings2", {
	font = "Arial", 
	size = ScreenScale(25), 
	weight = 1000, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

surface.CreateFont( "TheDefaultSettings3", {
	font = "Arial", 
	size = ScreenScale(15), 
	weight = 1000, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )

--[[hook.Add( "HUDPaint", "drawTextExample", function()
	draw.SimpleText(CurTime(), "TheDefaultSettings", ScrW() / 2, ScrH() / 2, COLOR_WHITE, TEXT_ALIGN_CENTER)
end ) ]]--

local function HUDPaint()
 
	if( !client:Alive( ) ) then return; end				-- don't draw if the client is dead

	draw.SimpleText("Enot", "TheDefaultSettings", ScrW() / 2 + 1, ScrH() - 56 + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("Enot", "TheDefaultSettings", ScrW() / 2, ScrH() - 56, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end

hook.Add( "HUDPaint", "PaintHud", HUDPaint );