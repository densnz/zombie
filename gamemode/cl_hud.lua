local HealthRing = Material("512r.png")
local Health2Ring = Material("10pt_2.png")
--local fontik = "fontiwe"

--surface.CreateFont( fontik, { fontik = "Default", 48, weight = 200 } )
--surface.CreateLegacyFont("Terminal", 48, fontweight3D, false, false,  "ZS3D2DFont2Small", false, true)

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

	local insert = table.insert

	-- clamp func, to prevent going outside of the square
	local function clamp(v) if (v > 1) then return 1 else return v end end

	local function NiceUV(x, y, w, h, perc, flipped)
		
		if flipped then
		
			if (prec == 0) then return {} end

			local tbl = {} -- our pizza
			insert(tbl, {x = x, y = y, u = 0.5, v = 0.5}) -- add center point in the middle to make a pizza shape
			
			-- v = up/down
			-- u = left/right
			
			-- top right, first we move from the middle to the right
			if (perc >= 315) then
				insert(tbl, {x = x + w - clamp((perc - 315) / 45) * w, y = y - h, u = 1 - clamp((perc - 315) / 45) / 2, v = 0})
			end
			
			-- down right, then from right corner to bottom, it's easier in 90's
			if (perc >= 225) then
				insert(tbl, {x = x + w, y = y + h - clamp((perc - 225) / 90) * h * 2, u = 1, v = 1 - clamp((perc - 225) / 90)})
			end
			
			-- down left
			if (perc >= 135) then
				insert(tbl, {x = x - w + clamp((perc - 135) / 90) * h * 2, y = y + h, u = clamp((perc - 135) / 90), v = 1})
			end
			
			-- top left, and from bottom to up!
			if (perc >= 45) then
				insert(tbl, {x = x - w, y = y - h + clamp((perc - 45) / 90) * h * 2, u = 0, v = clamp((perc - 45) / 90)})
			end
			
			-- top center, now go back to close our pizza up. We dont need to do an if here, as this is the last peice of this godly meal.
			insert(tbl, {x = x - clamp(perc / 45) * w, y = y - h, u = 0.5 - clamp(perc / 45) / 2, v = 0})
			
			insert(tbl, {x = x, y = y - h, u = 0.5, v = 0}) -- add our startpoint for the pizza
			
			-- aparently, we got a full pizza! lets return this lovly meal.
			return tbl
		
		else

			local tbl = {} -- our pizza
			insert(tbl, {x = x, y = y, u = 0.5, v = 0.5}) -- add center point in the middle to make a pizza shape
			insert(tbl, {x = x, y = y - h, u = 0.5, v = 0}) -- add our startpoint for the pizza
			
			-- v = up/down
			-- u = left/right
			
			 -- top right, first we move from the middle to the right
			if (perc > 45) then insert(tbl, {x = x + w, y = y - h, u = 1, v = 0})
			else				insert(tbl, {x = x + perc / 45 * w, y = y - h, u = 0.5 + clamp(perc / 45) / 2, v = 0}) return tbl
			end
			
			-- down right, then from right corner to bottom, it's easier in 90's
			perc = perc - 45 -- remove the perc, this makes math easier later on
			if (perc > 90) then 
				insert(tbl, {x = x + w, y = y + h, u = 1, v = 1})
			else
				insert(tbl, {x = x + w, y = y - h + perc / 90 * h * 2, u = 1, v = clamp(perc / 90)}) return tbl
			end
			
			-- down left, then from right to left
			perc = perc - 90
			if (perc > 90) then 
				insert(tbl, {x = x - w, y = y + h, u = 0, v = 1})
			else
				insert(tbl, {x = x + w - perc / 90 * h * 2, y = y + h, u = 1 - clamp(perc / 90), v = 1}) return tbl
			end
			
			-- top left, and from bottom to up!
			perc = perc - 90
			if (perc > 90) then 
				insert(tbl, {x = x - w, y = y - h, u = 0, v = 0})
			else
				insert(tbl, {x = x - w, y = y + h - perc / 90 * h * 2, u = 0, v = 1 - clamp(perc / 90)}) return tbl
			end
			
			-- top center, now go back to close our pizza up. We dont need to do an if here, as this is the last peice of this godly meal.
			perc = perc - 90
			insert(tbl, {x = x - w + perc / 45 * w, y = y - h, u = clamp(perc / 45) / 2, v = 0})
			
			-- aparently, we got a full pizza! lets return this lovly meal.
			return tbl
		end
	end

	function CreateBorderedCircle(x, y, size, border, perc, addrot, parts)

		local sin = math.sin
		local cos = math.cos
		local rad = math.rad

		local parts = parts or 100

		local tbl = {}
		local onerad = rad(360) / parts
		local fixpos = rad(90)
		local ret = false
		local ending = perc * 3.6 * (parts / 360)
		local innersize = size - border
		local i = 0
		
		if (addrot != nil) then
			fixpos = fixpos + rad(addrot)
		end
		
		while(true) do
			if (not ret) then
				-- outside
				table.insert(tbl, {
					x = x - cos(i * onerad - fixpos) * innersize,
					y = y + sin(i * onerad - fixpos) * innersize
				})
			
				i = i + 1
				
				if (i > ending) then
					ret = true
					i = i - 1
				end
			else
				-- inside
				table.insert(tbl, {
					x = x - cos(i * onerad - fixpos) * size,
					y = y + sin(i * onerad - fixpos) * size
				})
				
				i = i - 1
				
				if (i < 0) then
					table.insert(tbl, {
						x = x + cos(fixpos) * size,
						y = y + sin(fixpos) * size
					})
					
					break
				end
			end
		end
		
		return tbl
	end

	function DrawCorrectFuckingPoly(tbl, fade)
		local len = #tbl

		for i = 1, #tbl do
			
			if fade and (i < 5 or i >= (len-5)) then
				local col = i / 5
				
				if i > len/2 then
					col = (len-i-1) / 5
				end
				
				surface.SetDrawColor( 175 * col, 225 * col, 100 * col, 200 * col )
			elseif fade then
				surface.SetDrawColor( 175, 225, 100, 200 )
			end
			
			surface.DrawPoly({tbl[i], tbl[len - (i - 1)], tbl[len - i]})
			surface.DrawPoly({tbl[i], tbl[i + 1], tbl[len - i]})
		end
	end

good_hud = { };
 
local function clr( color ) return color.r, color.g, color.b, color.a; end
 
function good_hud:PaintHealthCircle( x, y, w, h )

	surface.SetDrawColor(Color(0,0,0,200))
	surface.SetMaterial(HealthRing)
	local h2parts = NiceUV(x, y, w, h, 360, true)
	surface.DrawPoly(h2parts)
	
	if LocalPlayer():Health() / LocalPlayer():GetMaxHealth() > 0.35 then
		surface.SetDrawColor(Color(255,255,255))
		if LocalPlayer():Health() < 1000 then
			draw.SimpleText(LocalPlayer():Health(), "TheDefaultSettings", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(LocalPlayer():Health(), "TheDefaultSettings", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(LocalPlayer():Health(), "TheDefaultSettings1.5", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(LocalPlayer():Health(), "TheDefaultSettings1.5", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	else
		surface.SetDrawColor(Color(231, 76, 60))
		draw.SimpleText(LocalPlayer():Health(), "TheDefaultSettings", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(LocalPlayer():Health(), "TheDefaultSettings", x, y, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	surface.SetMaterial(Health2Ring)
	if LocalPlayer():Team() == TEAM_HUMAN then
		local nyooon = math.Clamp(LocalPlayer():Health(), 0, LocalPlayer():GetMaxHealth()) / LocalPlayer():GetMaxHealth() * 360
		local hparts = NiceUV(x, y, w, h, nyooon, true)
		surface.DrawPoly(hparts)
	else
		local nyooon = math.Clamp(LocalPlayer():Health(), 0, LocalPlayer():GetMaxHealth()) / LocalPlayer():GetMaxHealth() * 360
		local hparts = NiceUV(x, y, w, h, nyooon, true)
		surface.DrawPoly(hparts)
	end
end

function good_hud:PaintWavesTimeCircle( x, y, w, h )
	
	surface.SetDrawColor(Color(0,0,0,200))
	surface.SetMaterial(HealthRing)
	local h2parts = NiceUV(x, y, w, h, 360, true)
	surface.DrawPoly(h2parts)
	
	if GAMEMODE:GetWave() <= 0 then
			local timeleft = math.max(0, GAMEMODE:GetWaveStart() - CurTime())
			if timeleft < 11 then 
				surface.SetDrawColor(Color(231, 76, 60))
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				surface.SetDrawColor(Color(255,255,255))
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			surface.SetMaterial(Health2Ring)
			local nyooon = math.Clamp(timeleft, 0, GAMEMODE:GetWaveStart()) / GAMEMODE:GetWaveStart() * 360
			local aparts = NiceUV(x, y, w, h, nyooon, true)
			surface.DrawPoly(aparts)
			draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif GAMEMODE:GetWaveActive() then
			local waveend = GAMEMODE:GetWaveEnd()
			if waveend ~= -1 then
				local timeleft = math.max(0, waveend - CurTime())
				if timeleft < 11 then 
					surface.SetDrawColor(Color(231, 76, 60))
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					surface.SetDrawColor(Color(255,255,255))
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				surface.SetMaterial(Health2Ring)
				local nyooon1 = math.Clamp(GAMEMODE:GetWaveEnd() - CurTime(), 0, GAMEMODE:GetWaveEnd() - GAMEMODE:GetWaveStart()) / (GAMEMODE:GetWaveEnd() - GAMEMODE:GetWaveStart()) * 360
				local bparts = NiceUV(x, y, w, h, nyooon1, true)
				surface.DrawPoly(bparts)
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		else
			local wavestart = GAMEMODE:GetWaveStart()
			if wavestart ~= -1 then
				local timeleft = math.max(0, wavestart - CurTime())
				if timeleft < 11 then 
					surface.SetDrawColor(Color(231, 76, 60))
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(231, 76, 60), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					surface.SetDrawColor(Color(255,255,255))
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				surface.SetMaterial(Health2Ring)
				local nyooon2 = math.Clamp(GAMEMODE:GetWaveStart() - CurTime(), 0, GAMEMODE:GetWaveStart() - GAMEMODE:GetWaveEnd()) / (GAMEMODE:GetWaveStart() - GAMEMODE:GetWaveEnd()) * 360
				local cparts = NiceUV(x, y, w, h, nyooon2, true)
				surface.DrawPoly(cparts)
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x + 1, y + 1, Color(0, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(string.ToMinutesSeconds(timeleft), "TheDefaultSettings2", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
end

function good_hud:PaintWavesCircle( x, y, w, h)
	
	surface.SetDrawColor(Color(0,0,0,200))
	surface.SetMaterial(HealthRing)
	local nyooon2 = math.Clamp(100, 0, 100) / 100 * 360
	local h2parts = NiceUV(x, y, w, h, nyooon2, true)
	surface.DrawPoly(h2parts)
	
	surface.SetDrawColor(Color(255,255,255,255))
	surface.SetMaterial(Health2Ring)
	local nyooon = math.Clamp(GAMEMODE:GetWave(), 0, GAMEMODE:GetNumberOfWaves()) / GAMEMODE:GetNumberOfWaves() * 360
	local wparts = NiceUV(x, y, w, h, nyooon, false)
	surface.DrawPoly(wparts)
	
	draw.SimpleText(GAMEMODE:GetWave().."/"..GAMEMODE:GetNumberOfWaves(), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText(GAMEMODE:GetWave().."/"..GAMEMODE:GetNumberOfWaves(), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

end

function good_hud:PaintPoisonCircle( x, y, w, h )
 
        if LocalPlayer():GetPoisonDamage() > 0 then
       
        surface.SetDrawColor(Color(0,0,0,200))
        surface.SetMaterial(HealthRing)
       
 
        local nyooon2 = math.Clamp(100, 0, 100) / 100 * 360
        local h2parts = NiceUV(x, y, w, h, nyooon2, true)
        surface.DrawPoly(h2parts)
       
        surface.SetDrawColor(Color(255,255,255,255))
        surface.SetMaterial(Health2Ring)
        local nyooon = math.Clamp(LocalPlayer():GetPoisonDamage(), 0, 50) / 50 * 360
        local wparts = NiceUV(x, y, w, h, nyooon, false)
        surface.DrawPoly(wparts)
       
       
                draw.SimpleText(LocalPlayer():GetPoisonDamage(), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(LocalPlayer():GetPoisonDamage(), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
end

function good_hud:PaintAmmoCircle( x, y, w, h )

	if LocalPlayer():GetActiveWeapon() ~= NULL and (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_zs_medicalkit" or LocalPlayer():GetActiveWeapon():GetClass() == "weapon_zs_hammer") then
		if LocalPlayer():GetActiveWeapon():GetClass() == "weapon_zs_medicalkit" then
			surface.SetDrawColor(Color(0,0,0,200))
			surface.SetMaterial(HealthRing)
			local nyooon2 = math.Clamp(100, 0, 100) / 100 * 360
			local h2parts = NiceUV(x, y, w, h, nyooon2, true)
			surface.DrawPoly(h2parts)
			
			surface.SetDrawColor(Color(231, 76, 60))
			surface.SetMaterial(Health2Ring)
			local nyooon = math.Clamp(math.min(1, (LocalPlayer():GetActiveWeapon():GetNextCharge() - CurTime()) / math.max(LocalPlayer():GetActiveWeapon().Primary.Delay, LocalPlayer():GetActiveWeapon().Secondary.Delay)) * 100, 0, 100) / 100 * 360
			local wparts = NiceUV(x, y, w, h, nyooon, false)
			surface.DrawPoly(wparts)
			
			if LocalPlayer():GetActiveWeapon():GetNextCharge() < CurTime() then
				surface.SetDrawColor(Color(255,255,255,255))
				local wparts = NiceUV(x, y, w, h, 360, false)
				surface.DrawPoly(wparts)
			end
			
			draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount(), "TheDefaultSettings", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount(), "TheDefaultSettings", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif LocalPlayer():GetActiveWeapon():GetClass() == "weapon_zs_hammer" then
			surface.SetDrawColor(Color(0,0,0,200))
			surface.SetMaterial(HealthRing)
			local nyooon2 = math.Clamp(100, 0, 100) / 100 * 360
			local h2parts = NiceUV(x, y, w, h, nyooon2, true)
			surface.DrawPoly(h2parts)
			
			surface.SetDrawColor(Color(255,255,255,255))
			surface.SetMaterial(Health2Ring)
			local nyooon = math.Clamp(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount(), 0, LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount()) / LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount() * 360
			local wparts = NiceUV(x, y, w, h, nyooon, false)
			surface.DrawPoly(wparts)
			
			draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount(), "TheDefaultSettings", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoCount(), "TheDefaultSettings", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	else return end
end

function good_hud:PaintPoints( x, y, w, h)
	if LocalPlayer():Team() == TEAM_HUMAN then
		draw.SimpleText(translate.Format("points_x", LocalPlayer():GetPoints().." / "..LocalPlayer():Frags()), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(translate.Format("points_x", LocalPlayer():GetPoints().." / "..LocalPlayer():Frags()), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText(translate.Format("brains_eaten_x", LocalPlayer():Frags().." / "..GAMEMODE:GetRedeemBrains()), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(translate.Format("brains_eaten_x", LocalPlayer():Frags().." / "..GAMEMODE:GetRedeemBrains()), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

function good_hud:PaintServerName(x,y)
	draw.SimpleText(GetHostName(), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText(GetHostName(), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
end

function good_hud:PaintWaveStatus(x,y)
	if GAMEMODE:GetWave() == 0 then
		draw.SimpleText(translate.Get("prepare_yourself"), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(translate.Get("prepare_yourself"), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif GAMEMODE.ZombieEscape then
		draw.SimpleText(translate.Get("zombie_escape"), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(translate.Get("zombie_escape"), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif not GAMEMODE:GetWaveActive() then
		draw.SimpleText(translate.Get("intermission"), "TheDefaultSettings3", x + 1, y + 1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(translate.Get("intermission"), "TheDefaultSettings3", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	elseif GAMEMODE:GetWaveActive() then return end
end

function good_hud:TextSize( text, font )
 
	surface.SetFont( font );
	return surface.GetTextSize( text );
 
end
 
local vars =
{
 
	--font = "TargetID",
	font = "TheDefaultSettings",
 
	padding = 10,
	margin = 35,
 
	text_spacing = 0,
	bar_spacing = 5,
 
	bar_height = 16,
 
	width = 0.06
 
};

local function HUDPaint( )
 
	client = client or LocalPlayer( );				-- set a shortcut to the client
	if( !client:Alive( ) ) then return; end				-- don't draw if the client is dead
 
	local _, th = good_hud:TextSize( "TEXT", vars.font );		-- get text size( height in this case )
 
	local i = 2;							-- shortcut to how many items( bars + text ) we have
 
	local width = vars.width * ScrW( );				-- calculate width
	local bar_width = width - ( vars.padding * i );			-- calculate bar width and element height
	local height = ( vars.padding * i ) + ( th * i ) + ( vars.text_spacing * i ) + ( vars.bar_height * i ) + vars.bar_spacing;
 
	local x, y = ScreenScale( 53 ), ScreenScale( 53 )
 
	local cx = x + vars.padding;					-- get x and y of contents
	local cy = y + vars.padding;
 
	local by = th + vars.text_spacing;				-- calc text position
 
	local text = client:Health()
 
	by = by + vars.bar_height + vars.bar_spacing;			-- increment text position
 
	local text = string.format( "Suit: %iSP", client:Armor( ) );	-- get suit text
	good_hud:PaintHealthCircle(x + ScrW() * 0.04, y + ScrH() * 0.81, ScreenScale(bar_width), ScreenScale(bar_width))
	good_hud:PaintPoisonCircle(ScreenScale(ScrW() * 0.14), ScreenScale(ScrH() * 0.87), ScreenScale(bar_width) * 0.3, ScreenScale(bar_width) * 0.3)
	good_hud:PaintAmmoCircle(x + ScrW() * 0.89 --[[ScrW() * 0.92]], y + ScrH() * 0.81 --[[ScrH() * 0.875]], ScreenScale(bar_width), ScreenScale(bar_width))
	good_hud:PaintWavesTimeCircle(ScreenScale(ScrW() * 0.06), ScreenScale(ScrH() * 0.10), ScreenScale(bar_width) * 0.7, ScreenScale(bar_width) * 0.7)
	good_hud:PaintWavesCircle(ScreenScale(ScrW() * 0.11), ScreenScale(ScrH() * 0.06), ScreenScale(bar_width) * 0.3, ScreenScale(bar_width) * 0.3)
	good_hud:PaintPoints(ScreenScale(ScrW() * 0.06), ScreenScale(ScrH() * 0.17), ScreenScale(bar_width) * 0.7, ScreenScale(bar_width) * 0.7)
	good_hud:PaintServerName(ScrW()/2, ScrH())
	good_hud:PaintWaveStatus(ScreenScale(ScrW() * 0.06), ScreenScale(ScrH() * 0.025))
end
hook.Add( "HUDPaint", "PaintOurHud", HUDPaint );