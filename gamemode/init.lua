AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_set_team.lua" )

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "sh_globals.lua" )

AddCSLuaFile( "player.lua" )



include( "shared.lua" )
include( "sh_globals.lua" )
include( "player.lua" )

DEFINE_BASECLASS( "gamemode_base" )

function SetTeamSurvivor(pl)
	if ( pl:Team() == TEAM_CONNECTING || pl:Team() == TEAM_SPECTATOR || pl:Team() == TEAM_UNASSIGNED ) then
		pl:SetTeam( TEAM_SURVIVOR )
		ChoosePlayerSkin(pl)
		pl:SetupHands(pl)
		return
	end
end

function SetTeamZombie(pl)
	if ( pl:Team() == TEAM_SURVIVOR ) then
		pl:SetTeam( TEAM_ZOMBIE )
		ChoosePlayerSkin(pl)
	end
end

hook.Add("PlayerInitialSpawn", "FirstSpawn", function (pl)
	FirstSpawn(pl)
	SetTeamSurvivor(pl)
end)

hook.Add("PlayerDeath", "SwitchTeam", function (pl)
	if ( pl:Team() == TEAM_SURVIVOR ) then
		SetTeamZombie(pl)
	end
end)

hook.Add("PlayerSpawn", "GiveWeap", function (pl)
	pl:StripAmmo()
	pl:StripWeapons()
	if ( pl:Team() == TEAM_SURVIVOR ) then
		pl:Give( "weapon_pistol" )
		pl:GiveAmmo( 90, "Pistol", true )
    elseif ( pl:Team() == TEAM_ZOMBIE ) then
		pl:Give( "weapon_crowbar" )
    end 
end)
 

 ------------------- TESTING FUNCTIONS -------------------
 function SpawnTeamZombie(pl) 
     pl:SetTeam( TEAM_ZOMBIE )
	 pl:Spawn()
 end 
 
 function SpawnTeamSurvivor(pl) 
     pl:SetTeam( TEAM_SURVIVOR )
	 pl:Spawn()
 end 

 concommand.Add( "TEAM_ZOMBIE", SpawnTeamZombie )
 concommand.Add( "TEAM_SURVIVOR", SpawnTeamSurvivor )

 ---------------------------------------------------------

 --[[util.AddNetworkString( "SendAge" )

net.Receive( "SendAge", function( len, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
	 local age = net.ReadUInt( 8 ) -- Notice how ReadUInt requires an argument. This is the second argument of WriteUInt, which tells us how big the number is.
	 PrintMessage( HUD_PRINTTALK, ply:Nick() .. " is " .. age .. " years old!" )
end ) --]]