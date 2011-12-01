--SANGUOSHA Standard Version Generals--
--Design: YOKA
--Code: hypercross ibicdlcod roxiel ��Ⱥ������
--Version��14.01 (After Chibi 14)
--Last Update��2011-12-1 UTC+8

module("extensions.YKStdGeneral", package.seeall)

extension = sgs.Package("YKStdGeneral")

--0101 ����
luarende_card = sgs.CreateSkillCard
{--�ʵ¼��ܿ� by roxiel, ibicdlcod�޸�����BUG
	name = "luarendecard",
	target_fixed = true,	--��ʵ������Բ���FIX������������Ҳ�� ��ѡ����ѡ��
	will_throw = false,		--����
	once = false,
	
	on_use = function(self, room, source, targets)
		source:gainMark("luarendecount", self:subcardsLength())
		
		--[[ȷ�ϴ˴�ʧЧ��Ҳ�ޱ�Ҫ
        local log = sgs.LogMessage()
        log.from:append(source)
        log.type ="#luarende"                                  
        room:sendLog(log)]]
				
        local t = room:askForPlayerChosen(source, room:getOtherPlayers(source), "luarende")        
		room:playSkillEffect("luarende",math.random(1, 2))
		room:moveCardTo(self, t, sgs.Player_Hand, false)        
        local x = source:getMark("luarendecount")
        if  x >= 2 and not source:hasFlag("recovered") then --����������û�лظ����ı�ǣ��Ͳ�Ѫ Ȼ���������
            local recover = sgs.RecoverStruct()   --�ظ��ṹ��
            recover.recover = 1  --�ظ�����
            recover.who = source   --�ظ���Դ
            room:recover(source,recover)
        if source:isKongcheng() then                                
            room:setPlayerFlag(source,"-luarende_canuse")                --�ճǾͽ��ü���
        end        
        return true
	end
end,
}

luarendevs = sgs.CreateViewAsSkill
{--�ʵ���Ϊ�� by roxiel
	name = "luarendevs",
	n = 999,
	
	view_filter = function(self, selected, to_select)
        if to_select:isEquipped() then return false end                        --װ��������ʹ��
        return true 
	end,
	
	view_as = function(self, cards)        
        if #cards == 0 then return end
        local acard = luarende_card:clone()
        for var = 1, #cards, 1 do   --������ѡ�е��Ƽ����ʵ¼����Ƶ�Subcards     
            acard:addSubcard(cards[var])                
        end
        acard:setSkillName(self:objectName())
        return acard        
	end,
	
	enabled_at_play = function()
        return sgs.Self:hasFlag("luarende_canuse")    
	end,
}

luarende = sgs.CreateTriggerSkill
{--�ʵ� by roxiel
	name = "luarende",
	view_as_skill = luarendevs,
	events = {sgs.PhaseChange},
	
	on_trigger = function(self, event, player, data)
        local room = player:getRoom()                
        if player:getPhase() == sgs.Player_Play then             
			room:setPlayerFlag(player, "luarende_canuse")    --�غϿ�ʼ ��VIEWAS����ʹ��
        else if player:getPhase() == sgs.Player_Finish then
			room:setPlayerFlag(player, "-luarende_canuse")  --�غϽ��� ��VIEWAS����
		    room:setPlayerMark(player, "luarendecount",0)   --��������
		end
	end		
end,
}

--0102 ����
luawusheng = sgs.CreateViewAsSkill
{--��ʥ by ��Ⱥ������
	name = "luawusheng",
	n = 1,
	
	view_filter = function(self, selected, to_select)
        return to_select:isRed() 
	end,
	
	view_as = function(self, cards)
        if #cards == 0 then return nil end
		if #cards == 1 then         
            local card = cards[1]
			local acard = sgs.Sanguosha:cloneCard("slash", card:getSuit(), card:getNumber()) 
            acard:addSubcard(card:getId())
            acard:setSkillName(self:objectName())
			return acard
        end
	end,
	
	enabled_at_play = function()
        return (sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Crossbow")
	end,
	
	enabled_at_response = function(self, player, pattern)
		return pattern == "slash"
	end,
}

--0103 �ŷɣ�lua���ܣ�

--0104 �����
luaguanxing = sgs.CreateTriggerSkill
{--���� by ��Ⱥ������
	name = "luaguanxing",
	frequency = sgs.Skill_Frequent,
	events = {sgs.PhaseChange},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if (player:getPhase() == sgs.Player_Start) then
			if (not room:askForSkillInvoke(player,self:objectName())) then return false end
				local x = room:alivePlayerCount()
				if x > 5 then 
					x = 5 
				end 
			room:doGuanxing(player,room:getNCards(x),false)
		end
	end,
}

luakongcheng = sgs.CreateProhibitSkill
{--�ճ� by ��Ⱥ������
	name = "luakongcheng",
	is_prohibited = function(self, from, to, card)
		if(to:hasSkill("luakongcheng")) and (to:isKongcheng()) then
			return card:inherits("Slash") or card:inherits("Duel")
		end
	end,
}

--0105 ����
ldtmp={}
lualongdan = sgs.CreateViewAsSkill
{--���� by ��Ⱥ������
	name = "lualongdan",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		return (to_select:inherits("Slash")) or (to_select:inherits("Jink"))
	end,
	
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local ld_card = sgs.Sanguosha:cloneCard(ldtmp[1], cards[1]:getSuit(), cards[1]:getNumber())
			ld_card:addSubcard(cards[1])
			ld_card:setSkillName(self:objectName())
			return ld_card
		end
	end,
	
	enabled_at_play = function() 
        ldtmp[1] = "slash"
        return(sgs.Self:canSlashWithoutCrossbow()) or (sgs.Self:getWeapon() and sgs.Self:getWeapon():className() == "Crossbow")
	end,
	
	enabled_at_response = function(self, player, pattern)
		if(pattern == "jink") or (pattern == "slash") then 
			ldtmp[1] = pattern
			return true 
		end
	end,
}

--0106 ��
luatieqi = sgs.CreateTriggerSkill
{--���� by ��Ⱥ������
	name = "luatieqi",
	frequency = sgs.Skill_Frequency,
	events = {sgs.SlashProceed},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		if event == sgs.SlashProceed then
			if (not room:askForSkillInvoke(player, self:objectName())) then return false end 
	
			local judge = sgs.JudgeStruct()
			judge.pattern = sgs.QRegExp("(.*):(heart|diamond):(.*)")
			judge.good = true
			judge.reason = self:objectName()
			judge.who = player
			room:judge(judge)
			if(judge:isGood()) then
				local effect = data:toSlashEffect()
				room:slashResult(effect, nil)      
				return true
			end
		end
	end
}

luamashu = sgs.CreateDistanceSkill
{--���� by ��Ⱥ������
	name = "luamashu",
	correct_func = function(self, from, to)
		if from:hasSkill("luamashu") then
			return -1
		end
	end,
}

--0107 ����Ӣ �����ȷ��lua���ܣ�
luajizhi = sgs.CreateTriggerSkill
{--���� by ��Ⱥ������
	name = "luajizhi",
	events = {sgs.CardUsed},
	frequency = sgs.Skill_Frequent,
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local card = data:toCardUse().card
		if card:isNDTrick() then 
			if not room:askForSkillInvoke(player, "luajizhi") then return false end
			player:drawCards(1) 
		end 
	end,
} 

--0201 �ܲ�
luajianxiong = sgs.CreateTriggerSkill
{--���� by hypercross
	frequency = sgs.Skill_NotFrequent,
	name = "luajianxiong",
	events = {sgs.Damaged},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local card = data:toDamage().card
		if not room:obtainable(card, player) then return end
		if room:askForSkillInvoke(player, "luajianxiong") then
			room:playSkillEffect("luajianxiong")
			player:obtainCard(card)
		end
	end
}

luahujia = sgs.CreateTriggerSkill
{--���� by ibicdlcod
	name = "luahujia$",
	default_choice = "ignore",
	events = {sgs.CardAsked, sgs.Damaged},
	
	on_trigger = function(self,event,player,data)
		local room = player:getRoom()
		if(not player:hasLordSkill("luahujia")) then return false end
		
		if(data:toString() ~= "jink") then return false end
		
		if(not room:askForSkillInvoke(player, "luahujia")) then return false end
		room:playSkillEffect("luahujia")
		for _,liege in sgs.qlist(room:getOtherPlayers(player)) do
			local data = sgs.QVariant(0)
			local jink = 0
			if(liege:getKingdom() ~= "wei") then return false end
			data:setValue(player)
			jink = room:askForCard(liege, "jink", "@hujia-jink", data)
			if(jink) then
				room:provide(jink)
				return true
			end
		end
		return false
	end
	--��ʵ�ϣ�Masochism������࣬�����ƺ������⣬���Ҵ�����ɫ�ʣ����鲻��
}

--0202 ˾��ܲ
luafankui = sgs.CreateTriggerSkill
{--���� by ibicdlcod
	frequency = sgs.Skill_NotFrequent,
	name = "luafankui",
	events = {sgs.Damaged},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local from = data:toDamage().from
		local data = sgs.QVariant(0)
		data:setValue(from)
		if(from and (not from:isNude()) and room:askForSkillInvoke(player, "luafankui", data)) then
			local card_id = room:askForCardChosen(player, from, "he", "luafankui")
			if(room:getCardPlace(card_id) == sgs.Player_Hand) then
				room:moveCardTo(sgs.Sanguosha:getCard(card_id), player, sgs.Player_Hand, false)
			else
				room:obtainCard(player, card_id)
			end
			room:playSkillEffect("luafankui")
		end
	end

}

luaguicai_card = sgs.CreateSkillCard
{--��ż��ܿ� by roxiel
	name = "luaguicai_effect",
	target_fixed = true,
	will_throw = false,
}

luaguicaivs = sgs.CreateViewAsSkill
{--���Viewas by roxiel
	name = "luaguicaivs",
	n = 1,
	
	view_filter = function(self, selected, to_select)        
        if not to_select:isEquipped() then return true
        else return false end
	end,
	
	view_as = function(self, cards)
        if #cards == 1 then 
        local acard = luaguicai_card:clone()        
        acard:addSubcard(cards[1])        
        acard:setSkillName("luaguicai")
        return acard end
	end,
	
	enabled_at_play = function()
        return false        
	end,
	
	enabled_at_response = function(self,pattern)
        return pattern == "@@luaguicai" --����Ӧ Ҫ��һ��luaguicai_card        
	end
}

luaguicai = sgs.CreateTriggerSkill
{--��� by roxiel
    name = "luaguicai",
    events = sgs.AskForRetrial,	--��˵����¼�����Ҫcantrigger
    view_as_skill = luaguicaivs,
	
    on_trigger = function(self, event, player, data)
        local room = player:getRoom()
        local simashi = room:findPlayerBySkillName(self:objectName())
        local judge = data:toJudge()	--��ȡ�ж��ṹ��        
		simashi:setTag("Judge",data)	--SET����ӵ����TAG
        if (room:askForSkillInvoke(simashi, self:objectName()) ~= true) then return false end	--ѯ�ʷ��� ����ȥ��
			local card = room:askForCard(simashi, "@@luaguicai", "@luaguicai", data)				--Ҫ��һ��luaguicai_card   ������@luaguicai��ѯ���ַ���     
			if card ~= nil then  -- ��������        
                room:throwCard(judge.card) --ԭ�ж��ƶ����������Ҫ����������滻������Ӧ�ø�Ϊsimashi:obtainCard(judge.card)
				judge.card = sgs.Sanguosha:getCard(card:getEffectiveId()) --�ж��Ƹ���
				room:moveCardTo(judge.card, nil, sgs.Player_Special) --�ƶ����ж���
				
				local log = sgs.LogMessage()  --LOG �����Ǹ��ж�ר�õ�TYPE
				log.type = "$ChangedJudge"
				log.from = player
				log.to:append(judge.who)
				log.card_str = card:getEffectIdString()
				room:sendLog(log)
				
				room:sendJudgeResult(judge) 
			end
        return false --ҪFALSE~~
    end,        
}

--0203 �ĺ
luaganglie = sgs.CreateTriggerSkill
{--���� by ibicdlcod	
	name = "luaganglie",
	events = {sgs.Damaged},
	
	on_trigger=function(self, event, player, data)
		local room = player:getRoom()
		local from = data:toDamage().from
		source = sgs.QVariant(0)
		source:setValue(from)
		
		if(from and from:isAlive() and room:askForSkillInvoke(player, "luaganglie", source)) then
			room:playSkillEffect("luaganglie")
			
			local judge = sgs.JudgeStruct()
			judge.pattern = sgs.QRegExp("(.*):(heart):(.*)")
			judge.good = false
			judge.reason = self:objectName()
			judge.who = player

			room:judge(judge)
			if(judge:isGood()) then
				if(not room:askForDiscard(from, "luaganglie", 2, true)) then
					local damage = sgs.DamageStruct()
					damage.from = player
					damage.to = from
					
					room:damage(damage)
				end
				room:setEmotion(player, "good")
			else
				room:setEmotion(player, "bad")
			end
		end
	end
}

--0204 ����
luatuxi_card = sgs.CreateSkillCard
{--ͻϮ���ܿ� by ibicdlcod
	name = "luatuxi_card",	
	target_fixed = false,	
	will_throw = false,

	filter = function(self, targets, to_select)
		if(#targets > 1) then return false end
		
		if(to_select == self) then return false end
		
		return not to_select:isKongcheng()
	end,
		
	on_effect = function(self, effect)
		local from = effect.from
		local to = effect.to
		local room = to:getRoom()
		local card_id = room:askForCardChosen(from, to, "h", "luatuxi_main")
		local card = sgs.Sanguosha:getCard(card_id)
		room:moveCardTo(card, from, sgs.Player_Hand, false)
		
		room:setEmotion(to, "bad")
		room:setEmotion(from, "good")
	end,
}

luatuxi_viewas = sgs.CreateViewAsSkill
{--ͻϮ��Ϊ�� by ibicdlcod
	name = "luatuxi_viewas",	
	n = 0,

	view_as = function()
		return luatuxi_card:clone()		
	end,
	
	enabled_at_play = function()
		return false
	end,
	
	enabled_at_response = function(player, pattern)
		return pattern == "@@luatuxi_main"
	end
}

luatuxi_main = sgs.CreateTriggerSkill
{--ͻϮ by ibicdlcod
	name = "luatuxi_main",
	view_as_skill = luatuxi_viewas,
	events = {sgs.PhaseChange},
	
	on_trigger = function(self, event, player, data)
		if(player:getPhase() == sgs.Player_Draw) then
			local room = player:getRoom()
			local can_invoke = false
			local other = room:getOtherPlayers(player)
			for _,aplayer in sgs.qlist(other) do
				if(not aplayer:isKongcheng()) then
					can_invoke = true
					break
				end
			end
			if(not room:askForSkillInvoke(player, "luatuxi_main")) then return false end
			if(can_invoke and room:askForUseCard(player, "@@luatuxi_main", "@luatuxi_card")) then return true end
		return false
		end
	end
}

--0205 ����
lualuoyi_buff = sgs.CreateTriggerSkill
{--����Ч�� by ibicdlcod
	name = "#lualuoyi",
	events = {sgs.Predamage},
	
	on_trigger = function(self, event, player, data)
		if(player:hasFlag("lualuoyi") and player:isAlive()) then
			local damage = data:toDamage()
			local room = player:getRoom()
			local reason = damage.card
			if(not reason) then return false end
			if(reason:inherits("Slash") or reason:inherits("Duel")) then
				
				local log = sgs.LogMessage()
				log.type = "#LuaLuoyiBuff"
				log.from = player
				log.to:append(damage.to)
				log.arg = tonumber(damage.damage)
				log.arg2 = log.arg+1
				room:sendLog(log)
				
				damage.damage = damage.damage+1
				data:setValue(damage)
				return false
			end
		else return false
		end
	end
}

lualuoyi = sgs.CreateTriggerSkill
{--���� by ibicdlcod
	name = "lualuoyi",	
	events = {sgs.DrawNCards},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local x = data:toInt()
		if(room:askForSkillInvoke(player, "lualuoyi")) then
		
			room:playSkillEffect("lualuoyi")
			
			player:setFlags("lualuoyi")
			data:setValue(x-1)
		end
	end
}

--0206 ����
luatiandu = sgs.CreateTriggerSkill
{--��� by ibicdlcod
	name = "luatiandu",	
	frequency = sgs.Skill_Frequent,
	events = {sgs.FinishJudge},
	
	on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local judge = data:toJudge()
		local card = judge.card
		data_card = sgs.QVariant(0)
		data_card:setValue(card)
		if(player:askForSkillInvoke("luatiandu", data_card)) then
			player:obtainCard(judge.card)
			room:playSkillEffect("luatiandu")
			return true
		end
		return false
	end
}

luayiji = sgs.CreateTriggerSkill
{--�ż� by roxiel, ibicdlcod�޸������Ʋ��ָܷ�����������ɫ��BUG
    name = "luayiji",
    frequency = sgs.Skill_Frequent,
    events = {sgs.Damaged},
	
    on_trigger = function(self, event, player, data)
		local room = player:getRoom()
		local damage = data:toDamage()    --��ȡ�˺��ṹ��
		if(not room:askForSkillInvoke(player, "luayiji"))
			then return false end
				
        room:playSkillEffect("luayiji")  --��Ч����Ч��LOG���ڷǺ��ĵ����ݣ��������¿հ�һ�У�
			
        for var = 1, damage.damage, 1 do   --ÿ���˺�ִ����������
            player:drawCards(2)   --��������ذ��������ˣ������Ժ�Ҳ�øģ�
			local hnum = player:getHandcardNum() --������
            local cdlist = sgs.IntList()   --Int���͵�list
            cdlist:append(player:handCards():at(hnum-1))   --���������
            cdlist:append(player:handCards():at(hnum-2))   --���ǲ��������
            room:askForYiji(player, cdlist)   --��������ں��Դ���һ�����������ʵ���ż���绨�˲��ٹ��򣬹���ͬ��
			if(player:getHandcardNum() == hnum-1) then
				celist = sgs.IntList()
				celist:append(player:handCards():at(hnum-2))
				room:askForYiji(player, celist)
			end
        end        
    end
}

--0207 �缧
luaqingguo = sgs.CreateViewAsSkill
{--��� by ibicdlcod, ��Ⱥ�������޸�response��Ч��BUG
	name = "luaqingguo",
	n = 1,
	
	view_filter = function(self, selected, to_select)
		return to_select:isBlack() and not to_select:isEquipped()
	end,
	
	view_as = function(self, cards)
		if #cards == 1 then
			local card = cards[1]
			local new_card = sgs.Sanguosha:cloneCard("jink", card:getSuit(), card:getNumber())
			new_card:addSubcard(card:getId())
			new_card:setSkillName(self:objectName())
			return new_card
		end
	end,
	
	enabled_at_play = function()
		return false
	end,
	
	enabled_at_response = function(self, player, pattern)
		return pattern == "jink"
	end
}

lualuoshen = sgs.CreateTriggerSkill
{--���� by ibicdlcod
	name = "lualuoshen",
	frequency = sgs.Skill_Frequent,
	events = {sgs.PhaseChange, sgs.FinishJudge},
	
	on_trigger = function(self, event, player, data)
		if(event == sgs.PhaseChange and player:getPhase() == sgs.Player_Start) then
			local room = player:getRoom()
			while(player:askForSkillInvoke("lualuoshen")) do
			
				room:playSkillEffect("lualuoshen")
				
				local judge = sgs.JudgeStruct()
                judge.pattern = sgs.QRegExp("(.*):(spade|club):(.*)")
                judge.good = true
                judge.reason = "lualuoshen"
                judge.who = player
                room:judge(judge)
				if(judge:isBad()) then break end
			end
		end
		if(event == sgs.FinishJudge) then
			judge = data:toJudge()
			if(judge.reason == "lualuoshen") then
				if(judge.card:isBlack()) then
					player:obtainCard(judge.card)
					return true
				end
			end
		end
	end
}

--0301 ��Ȩ
luazhiheng_card = sgs.CreateSkillCard
{--�ƺ⼼�ܿ� by hypercross, ibicdlcod�޸�getsubcards BUG
    name = "luazhiheng_card",
	target_fixed = true,
    will_throw = true,

    on_use = function(self, room, source, targets)
		if(source:isAlive()) then
			room:drawCards(source, self:subcardsLength())--����#getsubcards�ӵ���N�찡
			room:setPlayerFlag(source, "luazhiheng_used")		
			room:throwCard(self)
		end
    end,
}

luazhiheng = sgs.CreateViewAsSkill
{--�ƺ� by ibicdlcod **��֪����BUG���������ܲ���ʾ������**
	name = "luazhiheng",
	n = 998,--��˵�еġ�������������Ϊ998���ԣ�ֻҪ998����hypercross�
		
	view_filter = function(self, selected, to_select)
		return true
	end,
	
	view_as = function(self, cards)
		if #cards > 0 then
			local new_card = luazhiheng_card:clone()
			local i = 0
			while(i < #cards) do
				i = i + 1
				local card = cards[i]
				new_card:addSubcard(card:getId())
			end						
			new_card:setSkillName("luazhiheng")
			return new_card
		else return nil
		end
	end,
	
	enabled_at_play = function()
		return not sgs.Self:hasFlag("luazhiheng_used")
	end
}

luajiuyuan = sgs.CreateTriggerSkill
{--��Ԯ by ibicdlcod **δ���ԣ���ӭ����BUG**
	name = "luajiuyuan$",
	events = {sgs.Dying, sgs.AskForPeachesDone, sgs.CardEffected},
	frequency = sgs.Skill_Compulsory,
	
	on_trigger = function(self,event,player,data)
		local room = player:getRoom()
		if(not player:hasLordSkill("luajiuyuan")) then return false end
		
		if(event == sgs.Dying) then
			for _,liege in sgs.qlist(room:getOtherPlayers(player)) do
				if(liege:getKingdom() == "wu") then
					room:playSkillEffect("luajiuyuan", 1)
					break;
				end
			end
		end
		
		if(event == sgs.CardEffected) then
			local cardeffect = data:toCardEffect()
			if(effect.card:inherits("Peach") and effect.from:getKingdom() == "wu"
                   and player ~= effect.from and player:hasFlag("dying")) then
				local index = 0
				if(effect.from:getGeneral():isMale()) then index = 2 else index = 3 end
				room:playSkillEffect("jiuyuan", index);
                player:setFlags("jiuyuan")
				
				local log = sgs.LogMessage()
				log.from = player
				log.type = "#luaJiuyuanExtraRecover"
				log.from:append(player)
				log.to:append(effect.from)
				room:sendLog(log)
				
				local rec = sgs.RecoverStruct()
				rec.who = effect.from
				room:recover(player,rec)
				
				room:getThread():delay(1000)
			end
		end
		
		if(event == sgs.AskForPeachesDone) then
            if(player:getHp() > 0 and player:hasFlag("jiuyuan")) then
                room:playSkillEffect("jiuyuan", 4);
                player:setFlags("-jiuyuan");
			end
		end
	end
}

--0101
lualiubei = sgs.General(extension, "lualiubei$", "shu", 4)
lualiubei:addSkill(luarende)

--0102
luaguanyu = sgs.General(extension, "luaguanyu", "shu", 4)
luaguanyu:addSkill(luawusheng)

--0103
luazhangfei = sgs.General(extension, "luazhangfei", "shu", 4)
luazhangfei:addSkill("paoxiao")

--0104
luazhugeliang = sgs.General(extension, "luazhugeliang", "shu", 4)
luazhugeliang:addSkill(luaguanxing)
luazhugeliang:addSkill(luakongcheng)

--0105
luazhaoyun = sgs.General(extension, "luazhaoyun", "shu", 4)
luazhaoyun:addSkill(lualongdan)

--0106
luamachao = sgs.General(extension, "luamachao", "shu", 4)
luamachao:addSkill(luatieqi)
luamachao:addSkill(luamashu)

--0107
luahuangyueying = sgs.General(extension, "luahuangyueying", "shu", 3, false)
luahuangyueying:addSkill(luajizhi)
luahuangyueying:addSkill("qicai")

--0201
luacaocao = sgs.General(extension, "luacaocao$", "wei", 4)
luacaocao:addSkill(luajianxiong)
luacaocao:addSkill(luahujia)

--0202
luasimayi = sgs.General(extension, "luasimayi", "wei", 3)
luasimayi:addSkill(luafankui)
luasimayi:addSkill(luaguicai)

--0203
luaxiahoudun = sgs.General(extension, "luaxiahoudun", "wei", 4)
luaxiahoudun:addSkill(luaganglie)

--0204
luazhangliao = sgs.General(extension, "luazhangliao", "wei", 4)
luazhangliao:addSkill(luatuxi_main)

--0205
luaxuchu = sgs.General(extension, "luaxuchu", "wei", 4)
luaxuchu:addSkill(lualuoyi_buff)
luaxuchu:addSkill(lualuoyi)

--0206
luaguojia = sgs.General(extension, "luaguojia", "wei", 3)
luaguojia:addSkill(luatiandu)
luaguojia:addSkill(luayiji)

--0207
luazhenji = sgs.General(extension, "luazhenji", "wei", 3, false)
luazhenji:addSkill(luaqingguo)
luazhenji:addSkill(lualuoshen)

--0301
luasunquan = sgs.General(extension, "luasunquan$", "wu", 4)
luasunquan:addSkill(luazhiheng)
luasunquan:addSkill(luajiuyuan)

sgs.LoadTranslationTable{
	["!luacaocao"] = "0201", 
	["!luazhangliao"] = "0204", 
	["!luaguojia"] = "0206", 
	["!luaxiahoudun"] = "0203", 
	["!luasimayi"] = "0202", 
	["!luaxuchu"] = "0205", 
	["!luazhenji"] = "0207", 
	["!lualiubei"] = "0101", 
	["!luaguanyu"] = "0102", 
	["!luazhangfei"] = "0103", 
	["!luazhaoyun"] = "0105", 
	["!luamachao"] = "0106", 
	["!luazhugeliang"] = "0104", 
	["!luahuangyueying"] = "0107", 
	["!luasunquan"] = "0301", 
	["!luazhouyu"] = "0305", 
	["!lualumeng"] = "0303", 
	["!lualuxun"] = "0307", 
	["!luaganning"] = "0302", 
	["!luahuanggai"] = "0304", 
	["!luadaqiao"] = "0306", 
	["!luasunshangxiang"] = "0308", 
	["!lualubu"] = "0402", 
	["!luahuatuo"] = "0401", 
	["!luadiaochan"] = "0403",
}