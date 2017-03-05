local ver = "0.01"


if FileExist(COMMON_PATH.."MixLib.lua") then
 require('MixLib')
else
 PrintChat("MixLib not found. Please wait for download.")
 DownloadFileAsync("https://raw.githubusercontent.com/VTNEETS/NEET-Scripts/master/MixLib.lua", COMMON_PATH.."MixLib.lua", function() PrintChat("Downloaded MixLib. Please 2x F6!") return end)
end


if GetObjectName(GetMyHero()) ~= "Ekko" then return end


require("DamageLib")

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat('<font color = "#00FFFF">New version found! ' .. data)
        PrintChat('<font color = "#00FFFF">Downloading update, please wait...')
        DownloadFileAsync('https://raw.githubusercontent.com/allwillburn/Ekko/master/Ekko.lua', SCRIPT_PATH .. 'Ekko.lua', function() PrintChat('<font color = "#00FFFF">Update Complete, please 2x F6!') return end)
    else
        PrintChat('<font color = "#00FFFF">No updates found!')
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/allwillburn/Ekko/master/Ekko.version", AutoUpdate)


GetLevelPoints = function(unit) return GetLevel(unit) - (GetCastLevel(unit,0)+GetCastLevel(unit,1)+GetCastLevel(unit,2)+GetCastLevel(unit,3)) end
local SetDCP, SkinChanger = 0

local EkkoMenu = Menu("Ekko", "Ekko")

EkkoMenu:SubMenu("Combo", "Combo")

EkkoMenu.Combo:Boolean("Q", "Use Q in combo", true)
EkkoMenu.Combo:Boolean("W", "Use W in combo", true)
EkkoMenu.Combo:Boolean("E", "Use E in combo", true)
EkkoMenu.Combo:Boolean("R", "Use R in combo", true)
EkkoMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
EkkoMenu.Combo:Boolean("Cutlass", "Use Cutlass", true)
EkkoMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
EkkoMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)e3we3we3we3we3we3we3we3we3we3we3we3we3we3we3we3we3we3we3we3w2
EkkoMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
EkkoMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)
EkkoMenu.Combo:Boolean("Randuins", "Use Randuins", true)


EkkoMenu:SubMenu("AutoMode", "AutoMode")
EkkoMenu.AutoMode:Boolean("Level", "Auto level spells", false)
EkkoMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
EkkoMenu.AutoMode:Boolean("Q", "Auto Q", false)
EkkoMenu.AutoMode:Boolean("W", "Auto W", false)
EkkoMenu.AutoMode:Boolean("E", "Auto E", false)
EkkoMenu.AutoMode:Boolean("R", "Auto R", false)

EkkoMenu:SubMenu("LaneClear", "LaneClear")
EkkoMenu.LaneClear:Boolean("Q", "Use Q", true)
EkkoMenu.LaneClear:Boolean("W", "Use W", true)
EkkoMenu.LaneClear:Boolean("E", "Use E", true)
EkkoMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
EkkoMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)

EkkoMenu:SubMenu("Harass", "Harass")
EkkoMenu.Harass:Boolean("Q", "Use Q", true)
EkkoMenu.Harass:Boolean("W", "Use W", true)

EkkoMenu:SubMenu("KillSteal", "KillSteal")
EkkoMenu.KillSteal:Boolean("Q", "KS w Q", true)
EkkoMenu.KillSteal:Boolean("E", "KS w E", true)

EkkoMenu:SubMenu("AutoIgnite", "AutoIgnite")
EkkoMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

EkkoMenu:SubMenu("Drawings", "Drawings")
EkkoMenu.Drawings:Boolean("DQ", "Draw Q Range", true)

EkkoMenu:SubMenu("SkinChanger", "SkinChanger")
EkkoMenu.SkinChanger:Boolean("Skin", "UseSkinChanger", true)
EkkoMenu.SkinChanger:Slider("SelectedSkin", "Select A Skin:", 1, 0, 4, 1, function(SetDCP) HeroSkinChanger(myHero, SetDCP)  end, true)

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)

	--AUTO LEVEL UP
	if EkkoMenu.AutoMode.Level:Value() then

			spellorder = {_E, _W, _Q, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end
	end
        
        --Harass
          if Mix:Mode() == "Harass" then
            if EkkoMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 1075) then
				if target ~= nil then 
                                      CastSkillShot(_Q, target)
                                end
            end

            if EkkoMenu.Harass.W:Value() and Ready(_W) and ValidTarget(target, 1600) then
				CastTargetSpell(target, _W)
            end     
          end

	--COMBO
	  if Mix:Mode() == "Combo" then
            if EkkoMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 1075) then
			CastSpell(YGB)
            end

            if EkkoMenu.Combo.Randuins:Value() and Randuins > 0 and Ready(Randuins) and ValidTarget(target, 500) then
			CastSpell(Randuins)
            end

            if EkkoMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 550) then
			 CastTargetSpell(target, BOTRK)
            end

            if EkkoMenu.Combo.Cutlass:Value() and Cutlass > 0 and Ready(Cutlass) and ValidTarget(target, 1075) then
			 CastTargetSpell(target, Cutlass)
            end

            if EkkoMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 325) then
			 CastSkillShot(_E, target)
	    end

            if EkkoMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 1075) then
		     if target ~= nil then 
                         CastSkillShot(_Q, target)
                     end
            end

            if EkkoMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if EkkoMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 1075) then
			CastTargetSpell(target, Gunblade)
            end

            if EkkoMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if EkkoMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 1600) then
			CastTargetSpell(target, _W)
	    end
	    
	    
            if EkkoMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 1075) and (EnemiesAround(myHeroPos(), 1075) >= EkkoMenu.Combo.RX:Value()) then
			CastSpell(_R)
            end

          end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 1075) and EkkoMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastSkillShot(_Q, target)
		         end
                end 

                if IsReady(_E) and ValidTarget(enemy, 325) and EkkoMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSkillShot(_E, target)
  
                end
      end

      if Mix:Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if EkkoMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 1075) then
	        	CastSkillShot(_Q, target)
                end

                if EkkoMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 1600) then
	        	CastTargetSpell(target, _W)
	        end

                if EkkoMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 325) then
	        	CastSkillShot(_E, target)
	        end

                if EkkoMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if EkkoMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          end
      end
        --AutoMode
        if EkkoMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 1075) then
		      CastSkillShot(_Q, target)
          end
        end 
        if EkkoMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, 1600) then
	  	      CastTargetSpell(target, _W)
          end
        end
        if EkkoMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget(target, 325) then
		      CastSkillShot(_E, target)
        end
        if EkkoMenu.AutoMode.R:Value() then        
	  if Ready(_R) and ValidTarget(target, 1075) then
		      CastSpell(_R)
	  end
        end
                
	--AUTO GHOST
	if EkkoMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnDraw(function (myHero)
        
         if EkkoMenu.Drawings.DQ:Value() then
		DrawCircle(GetOrigin(myHero), 1075, 0, 200, GoS.Red)
	end

end)


OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()        
       
             

        if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		Mix:ResetAA()
	end	
               
        if unit.isMe and spell.name:lower():find("itemravenoushydracrescent") then
		Mix:ResetAA()
	end

end) 


local function SkinChanger()
	if EkkoMenu.SkinChanger.UseSkinChanger:Value() then
		if SetDCP >= 0  and SetDCP ~= GlobalSkin then
			HeroSkinChanger(myHero, SetDCP)
			GlobalSkin = SetDCP
		end
        end
end


print('<font color = "#01DF01"><b>Ekko</b> <font color = "#01DF01">by <font color = "#01DF01"><b>Allwillburn</b> <font color = "#01DF01">Loaded!')





