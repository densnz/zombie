
function SetTeamFormPanel()
 
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 400, 224 )
	frame:SetTitle( "Set Team" )
	frame:SetVisible( true )
	frame:SetDraggable( true )
	frame:ShowCloseButton( true )
	frame:Center() --frame:SetPos( ScrW() / 2 - 200, ScrH() / 2 - 200 ) --Set the window in the middle of the players screen/game window
	frame:MakePopup()
	 
	TeamZombie = vgui.Create( "DButton", frame )
	TeamZombie:SetPos( 0, 24 ) --Place it half way on the tall and 5 units in horizontal
	TeamZombie:SetSize( 400, 100 )
	TeamZombie:SetText( "Team Zombie" )
	TeamZombie.DoClick = function() 
	   	RunConsoleCommand( "TEAM_ZOMBIE" )
	end
	
	TeamSurvivor = vgui.Create( "DButton", frame )
	TeamSurvivor:SetPos( 0, 124 ) --TeamSurvivor:SetPos( frame:GetTall() / 2 + 50, 150 )
	TeamSurvivor:SetSize( 400, 100 )
	TeamSurvivor:SetText( "Team Survivor" )
	TeamSurvivor.DoClick = function()
	   	RunConsoleCommand( "TEAM_SURVIVOR" )
	end
	  
end

concommand.Add( "team_menu", SetTeamFormPanel )