include( "shared.lua" )

include( "cl_set_team.lua" )
include( "cl_hud.lua" )

DEFINE_BASECLASS( "gamemode_base" )


--[[---------------------------------------------------------
	Desc: Hides default join and leave messages in chat.
-----------------------------------------------------------]]
hook.Add( "ChatText", "hide_joinleave", function( index, name, text, typ )
	if ( typ == "joinleave" ) then return true end
end )