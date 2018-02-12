DEFINE_BASECLASS( "gamemode_base" )

function GM:PlayerSpawn( pl )
	
end

function FirstSpawn( pl )
    for k, v in pairs(player.GetAll()) do
        v:ChatPrint(pl:Nick().." присоединился к серверу")
    end
end

function ChoosePlayerSkin( pl )
	if ( pl:Team() == TEAM_SURVIVOR ) then
		pl:SetModel('models/player/group03/male_02.mdl')
    elseif ( pl:Team() == TEAM_ZOMBIE ) then
        pl:SetModel('models/player/group03/male_03.mdl')
    end 
end

function GM:PlayerLoadout( pl )
	
end