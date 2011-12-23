-- translation for CommonString

return {
	["spade"] = "黑桃",
	["club"] = "梅花",
	["heart"] = "红桃",
	["diamond"] = "方块",
	["basic"] = "基本牌",
	["trick"] = "锦囊牌",
	["equip"] = "装备牌",

	["lord"] = "主公",
	["loyalist"] = "忠臣",
	["rebel"] = "反贼",
	["renegade"] = "内奸",
	["spade_char"] = "♠",
	["club_char"] = "♣",
	["heart_char"] = "♥",
	["diamond_char"] = "♦",
	["no_suit_char"] = "<b>无色</b>",
	["start"] = "<font color='#daa520'>开始</font>",
	["judge"] = "<font color='#6b8e23'>判定</font>",
	["draw"] = "<font color='blue'>摸牌</font>",
	["play"] = "<font color='#9400d3'>出牌</font>",
	["discard"] = "<font color='red'>弃牌</font>",
	["finish"] = "<font color='#708090'>结束</font>",
	["online"] = "在线",
	["offline"] = "离线",
	["robot"] = "电脑",
	["trust"] = "托管",
	["cheat"] = "作弊",
	["yes"] = "是",
	["no"] = "否",

	["wei"] = "魏",
	["shu"] = "蜀",
	["wu"] = "吴",
	["qun"] = "群",

	["test"] = "测试",
	["sujiang"] = "稻草人",
	["sujiangf"] = "稻草人·女",

	["normal_nature"] = "<font color='yellow'><b>无属性</b></font>",
	["fire_nature"] = "<font color='yellow'><b>火属性</b></font>",
	["thunder_nature"] = "<font color='yellow'><b>雷属性</b></font>",

	["slash-jink"] = "%src 使用了【杀】，请打出一张【闪】",
	["duel-slash"] = "%src 向你【决斗】，你需要打出一张【杀】",
	["savage-assault-slash"] = "%src 使用了【南蛮入侵】，请打出一张【杀】以响应",
	["archery-attack-jink"] = "%src 使用了【万箭齐发】，请打出一张【闪】以响应",
	["collateral-slash"] = "%src 使用了【借刀杀人】，目标是 %dest，请打出一张【杀】以响应",

	["#Slash"] = "%from 对 %to 使用了<font color='red'><b>【杀】</b></font>",
	["#Jink"] = "%from 使用了<font color='yellow'><b>【闪】</b></font>",
	["#Murder"] = "%to<font color='yellow'><b>【%arg】</b></font> 阵亡了，凶手是 %from",
	["#Suicide"] = "%to<font color='yellow'><b>【%arg】</b></font> 自杀身亡",
	["#Contingency"] = "%to<font color='yellow'><b>【%arg】</b></font>阵亡了，死于天灾",

	["#AcquireSkill"] = "%from 获得了技能<font color='yellow'><b>【%arg】</b></font>",
	["#InvokeSkill"] = "%from 发动了技能<font color='yellow'><b>【%arg】</b></font>",
	["#TriggerSkill"] = "%from 的锁定技<font color='yellow'><b>【%arg】</b></font>被触发",
	["#ChooseSuit"] = "%from 选择了 <font color='yellow'><b>%arg</b></font> 花色",
	["#Transfigure"] = "%from 变身为 <font color='yellow'><b>%arg</b></font>",
	["#ChooseKingdom"] = "%from 选择了 <font color='yellow'><b>%arg</b></font> 作为自己的势力",

	["#Pindian"] = "%from 向 %to 发起了拼点",
	["$PindianResult"] = "%from 的拼点结果为 <font color='yellow'><b>%card</b></font>",
	["#PindianSuccess"] = "%from（对 %to）拼点成功",
	["#PindianFailure"] = "%from（对 %to）拼点失败",

	["#Damage"] = "%from 对 %to 造成了 <font color='yellow'><b>%arg</b></font> 点伤害<font color='yellow'><b>（%arg2）</b></font>",
	["#DamageNoSource"] = "%to 受到了 <font color='yellow'><b>%arg</b></font> 点伤害<font color='yellow'><b>（%arg2）</b></font>",
	["#IronChainDamage"] = "%from 处于连环状态，将受到铁锁连环传导的伤害",
	["#LoseHp"] = "%from <font color='red'><b>流失了 %arg 点体力</b></font>",

	["#AskForPeaches"] = "%from 向 %to 求桃，一共需要 <font color='#98fb98'><b>%arg</b></font> 个桃",
	["#Recover"] = "%from <font color='#98fb98'><b>回复了 %arg 点体力</b></font>",

	["#NullificationDetails"] = "无懈的对象是 %from 对 %to 的锦囊 <font color='yellow'><b>%arg</b></font>",
	["#DelayedTrick"] = "%from 的延时锦囊<font color='yellow'><b>【%arg】</b></font>开始判定",
	["$InitialJudge"] = "%from 最初的判定结果为 <font color='yellow'><b>%card</b></font>",
	["$ChangedJudge"] = "%from 把 %to 的判定结果改成了 <font color='yellow'><b>%card</b></font>",
	["$JudgeResult"] = "%from 最终的判定结果为 <font color='yellow'><b>%card</b></font>",
	["$ChangedPindian"] = "%from 替换了本次拼点中 %to 的拼点牌",
	["#SkipPhase"] = "%from 跳过了 %arg<font color='yellow'><b>阶段</b></font>",

	["#DrawNCards"] = "%from 摸了 <font color='yellow'><b>%arg</b></font> 张牌",
	["$DiscardCard"] = "%from 弃掉了 <font color='yellow'><b>%card</b></font>",
	["$Dismantlement"] = "%from 被拆掉了 <font color='yellow'><b>%card</b></font>",
	["$MoveCard"] = "%to 从 %from 处得到了 <font color='yellow'><b>%card</b></font>",
	["#MoveNCards"] = "%to 从 %from 处得到 <font color='yellow'><b>%arg</b></font> 张牌",
	["$PasteCard"] = "%from 对 %to 使用了 <font color='yellow'><b>%card</b></font>",
	["$PutCard"] = "%from 的 <font color='yellow'><b>%card</b></font> 被放置在了摸牌堆",
	["$RecycleCard"] = "%from 从弃牌堆回收了 <font color='yellow'><b>%card</b></font>",
	["$ShowCard"] = "%from 展示了 <font color='yellow'><b>%card</b></font>",
	["$TakeAG"] = "%from 拿走了 <font color='yellow'><b>%card</b></font>",
	["$LightningMove"] = "<font color='yellow'><b>%card</b></font> 从 %from 移动到 %to",

	["#ArmorNullify"] = "%from 的锁定技<font color='yellow'><b>【%arg】</b></font>被触发，<font color='yellow'><b>【%arg2】</b></font>对其无效",
	["#SkillAvoid"] = "%from 的锁定技<font color='yellow'><b>【%arg】</b></font>被触发，这张 <font color='yellow'><b>%arg2</b></font> 无法指定其为目标",
	["#SkillNullify"] = "%from 的锁定技<font color='yellow'><b>【%arg】</b></font>被触发，<font color='yellow'><b>【%arg2】</b></font>对其无效",

	["$Install"] = "%from 装备了 <font color='yellow'><b>%card</b></font>",
	["$Uninstall"] = "%from 卸掉了 <font color='yellow'><b>%card</b></font>",

	["#GetMark"] = "%from 得到了 %arg2 枚 %arg<font color='yellow'><b>标记</b></font>",
	["#LoseMark"] = "%from 失去了 %arg2 枚 %arg<font color='yellow'><b>标记</b></font>",

	["#TurnOver"] = "%from 将自己的武将牌翻面，现在是 <font color='yellow'><b>%arg</b></font>",
	["face_up"] = "<font color='yellow'><b>正面</b></font>",
	["face_down"] = "<font color='yellow'><b>背面</b></font>",

	["3v3:cw"] = "<font color='yellow'><b>顺时针</b></font>",
	["3v3:ccw"] = "<font color='yellow'><b>逆时针</b></font>",
	["cw"] = "<font color='yellow'><b>顺时针</b></font>",
	["ccw"] = "<font color='yellow'><b>逆时针</b></font>",
	["#TrickDirection"] = "%from 选择了 <font color='yellow'><b>%arg</b></font> 作为锦囊的结算顺序",
}
