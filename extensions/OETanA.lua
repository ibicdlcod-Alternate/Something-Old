module("extensions.OETanA", package.seeall)

extension = sgs.Package("OETanA")

--3100 ÊÇË­ÄØ£¿²»¸æËßÄã
puhui = sgs.CreateViewAsSkill
{--ÆÕ»Ô by ibicdlcod
	name = "puhui",
	n = 0,
	
	enabled_at_play = function()
		return not sgs.Self:hasFlag("puhui-used")
	end,
	
	view_as = function(self, cards)
		local pcard = puhui_card:clone()
		return pcard
	end
}

puhui_card = sgs.CreateSkillCard
{--ÆÕ»Ô¼¼ÄÜ¿¨ by ibicdlcod
	name = "puhui",
	target_fixed = false,
	will_throw = false,
	
	filter = function(self, targets, to_select)
		if(#targets ~= 0) then return false end
		return not to_select:isKongcheng()
	end,
	
	on_use = function(self, room, source, targets)
		local target = targets[1]
		room:askForSkillInvoke(source, "puhui")
		--[[for var = 0, source:getHandCardNum()-1, 1 do	
			room:showCard(source, source:handCards():at(var))
		end]]
		room:showAllCards(source)
		room:showAllCards(target)
		local card = sgs.Sanguosha:getCard(room:askForCardChosen(source, target, "h", "puhui"))
		if(card:inherits("Trickcard")) then
			room:throwCard(card)
		end
		room:setPlayerFlag(source, "puhui-used")
	end
}

if(OMEGAERA) then
	moligaloo = sgs.General(extension, "moligaloo$", "tan", 4)
else 
	moligaloo = sgs.General(extension, "moligaloo$", "wei", 4)
end
moligaloo:addSkill(puhui)

sgs.LoadTranslationTable{
	["#moligaloo"] = "3100",
}
