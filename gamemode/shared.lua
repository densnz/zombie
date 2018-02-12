include( "sh_globals.lua" )

GM.Name = "Base Gamemode"
GM.Author = "Enot"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode( "base" )

DEFINE_BASECLASS( "gamemode_base" )

team.SetUp(TEAM_ZOMBIE, "The Undead", Color(0, 255, 0, 255))
team.SetUp(TEAM_SURVIVORS, "Survivors", Color(0, 160, 255, 255))


