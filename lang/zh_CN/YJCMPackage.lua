-- translation for YJCM Package

return {
	["YJCM"] = "一将成名",

	--曹植
	["caozhi"] = "曹植",
	["luoying"] = "落英",
	[":luoying"] = "当其他角色的梅花牌因弃牌或判定而进入弃牌堆时，你可以立即获得之。";
	["jiushi"] = "酒诗",
	[":jiushi"] = "若你的武将牌正面朝上，你可以（在合理的时机）将你的武将牌翻面来视为使用一张【酒】；当你的武将牌背面朝上时，若你受到伤害，你可在伤害结算后将之翻回正面。",

	--于禁
	["yujin"] = "于禁",
	["yizhong"] = "毅重",
	[":yizhong"] = "<b>锁定技</b>，当你没装备防具时，黑色的【杀】对你无效。",

	--张春华
	["zhangchunhua"] = "张春华",
	["jueqing"] = "绝情",
	[":jueqing"] = "<b>锁定技</b>，你造成的伤害均为体力流失。",
	["shangshi"] = "伤逝",
	[":shangshi"] = "除弃牌阶段外，每当你的手牌数小于你已损失的体力值时，可立即将手牌数补至等同于你已损失的体力值。",
	["#Jueqing"] = "%from 的锁定技<font color='yellow'><b>【绝情】</b></font>被触发，%to 受到的 %arg 点伤害改为了体力流失",

	--法正
	["fazheng"] = "法正",
	["enyuan"] = "恩怨",
	[":enyuan"] = "<b>锁定技</b>，其他角色每令你回复1点体力，该角色摸一张牌；其他角色每对你造成一次伤害，须给你一张红桃手牌，否则该角色失去1点体力。",
	["xuanhuo"] = "眩惑",
	[":xuanhuo"] = "出牌阶段，你可将一张红桃手牌交给一名其他角色，然后，你获得该角色的一张牌并立即交给除该角色外的其他角色，每回合限一次。",
	["#EnyuanRecover"] = "%from 的锁定技<font color='yellow'><b>【恩怨】</b></font>被触发，为其回复体力的角色 %to 摸了 %arg 张牌",
	["@enyuan"] = "请展示一张红桃手牌并交给对方",

	--马谡
	["masu"] = "马谡",
	["xinzhan"] = "心战",
	[":xinzhan"] = "出牌阶段，若你的手牌数大于你的体力上限，你可以观看牌堆顶的三张牌，然后展示并获得其中任意数量的红桃牌，其余牌以任意顺序置于牌堆顶。每回合限用一次。\
	◆【心战】发动后，若你观看的牌中存在红桃牌，则你可以选择展示并获取，如果你不想获取全部红桃牌，则可以主动点击“确定”按钮，开始更改卡牌顺序。",
	["huilei"] = "挥泪",
	[":huilei"] = "<b>锁定技</b>，你死亡时，杀死你的角色立即弃置所有的牌。\
	◆技能发动时机和【行殇】、【武魂】相同，逆时针顺序结算。",
	["#XinzhanResult"] = "%from 的<font color='yellow'><b>【心战】</b></font>结果：%arg 张置于牌堆顶",
	["#HuileiThrow"] = "%from 的锁定技<font color='yellow'><b>【挥泪】</b></font>被触发，凶手 %to 需要弃掉所有的装备和手牌",

	--徐庶
	["xushu"] = "徐庶",
	["wuyan"] = "无言",
	[":wuyan"] = "<b>锁定技</b>，你使用的非延时类锦囊对其他角色无效；其他角色使用的非延时类锦囊对你无效。",
	["jujian"] = "举荐",
	[":jujian"] = "出牌阶段，你可以弃至多三张牌，然后让一名其他角色摸等量的牌；若你以此法弃牌不少于三张且均为同一类别，你回复1点体力。每回合限一次。",
	["#WuyanBad"] = "%from 的锁定技<font color='yellow'><b>【无言】</b></font>被触发，其锦囊<font color='yellow'><b>【%arg】</b></font>对 %to 无效",
	["#WuyanGood"] = "%from 的锁定技<font color='yellow'><b>【无言】</b></font>被触发， %to 的锦囊<font color='yellow'><b>【%arg】</b></font>对其无效",
	["#JujianRecover"] = "%from 发动技能<font color='yellow'><b>【举荐】</b></font>弃掉了三张 %arg",

	--凌统
	["lingtong"] = "凌统",
	["xuanfeng"] = "旋风",
	[":xuanfeng"] = "每当你失去一次装备区里的牌时，你可以执行下列两项中的一项：\
	1、视为对任意一名其他角色使用一张【杀】（此【杀】不计入每回合的使用限制）。\
	2、对与你距离1以内的一名其他角色造成1点伤害。",
	["xuanfeng:nothing"] = "不发动",
	["xuanfeng:damage"] = "对距离1以内的一名其他角色造成1点伤害",
	["xuanfeng:slash"] = "对除自己外任意一名角色使用一张【杀】",

	--吴国太
	["wuguotai"] = "吴国太",
	["ganlu"] = "甘露",
	[":ganlu"] = "出牌阶段，你可以选择两名角色，交换他们装备区里的所有牌。以此法交换的装备牌数差不能超过X（X为你已损失的体力值）。每回合限一次。",
	["buyi"] = "补益",
	[":buyi"] = "当有角色进入濒死状态时，你可以展示该角色的一张手牌：若此牌不为基本牌，则该角色弃掉这张牌并回复1点体力。\
	◆【补益】的发动时机优先于【桃】或【急救】，对刚进入濒死状态的目标发动【补益】后，不论结果如何都不可对其再次发动【补益】。",
	["#GanluSwap"] = "%from 交换了 %to 之间的装备",

	--徐盛
	["xusheng"] = "徐盛",
	["pojun"] = "破军",
	[":pojun"] = "你使用【杀】造成一次伤害，可令受到该伤害的角色摸X张牌，X为该角色当前的体力值（最多为5），然后该角色将其武将牌翻面。",

	--高顺
	["gaoshun"] = "高顺",
	["xianzhen"] = "陷阵",
	[":xianzhen"] = "出牌阶段，你可以与一名角色拼点：\
	★若你赢，你获得以下技能直到回合结束：无视与该角色的距离及其防具，可对该角色使用任意数量的【杀】。\
	★若你没赢，你不能使用【杀】直到回合结束。\
	每回合限一次。\
	◆【陷阵】拼点成功后，你仍然需要点击【陷阵】技能按钮才能对拼点目标发动技能效果。",
	["jinjiu"] = "禁酒",
	[":jinjiu"] = "<b>锁定技</b>，你的【酒】始终视为【杀】。",
	["jiejiu"] = "禁酒",
	[":jiejiu"] = "<b>锁定技</b>，你的【酒】始终视为【杀】。",
	["@xianzhen-slash"] = "你可以对陷阵目标不限次数出杀",

	--陈宫
	["chengong"] = "陈宫",
	["mingce"] = "明策",
	[":mingce"] = "出牌阶段，你可以交给任一其他角色一张装备牌或【杀】，该角色进行二选一：\
	1、视为对其攻击范围内的另一名由你指定的角色使用一张【杀】。\
	2、摸一张牌。\
	每回合限用一次。",
	["zhichi"] = "智迟",
	[":zhichi"] = "<b>锁定技</b>，你的回合外，你每受到一次伤害后，任何【杀】或非延时锦囊均对你无效，直到该回合结束。",
	["mingce:nothing"] = "收下此牌",
	["mingce:use"] = "视为对自己攻击范围内的另一名由 陈宫 指定的角色使用一张【杀】",
	["mingce:draw"] = "摸一张牌",
	["#ZhichiDamaged"] = "%from 受到了伤害，本回合内<font color='yellow'><b>【杀】</b></font>和非延时锦囊都将对其无效",
	["#ZhichiAvoid"] = "%from 的锁定技<font color='yellow'><b>【智迟】</b></font>被触发，<font color='yellow'><b>【杀】</b></font>和非延时锦囊对其无效",

	--武将技能台词
	["$luoying1"] = "别着急哟，给我就好～",
	["$luoying2"] = "这些都是我的！",
	["$jiushi1"] = "置酒高殿上，亲友从我游。",
	["$jiushi2"] = "走马行酒醴，驱车布肉鱼。",

	["$yizhong1"] = "不先为备，何以待敌。",
	["$yizhong2"] = "稳重行军，百战不殆！",

	["$jueqing1"] = "无来无去，不悔不怨。",
	["$jueqing2"] = "你的死活与我何干？",
	["$shangshi1"] = "自损八百，可伤敌一千。",
	["$shangshi2"] = "无情者伤人，有情者自伤。",

	["$enyuan1"] = "得人恩果千年记。",
	["$enyuan2"] = "滴水之恩，涌泉以报。",
	["$enyuan3"] = "谁敢得罪我！",
	["$enyuan4"] = "睚眦之怨，无不报复。",
	["$xuanhuo1"] = "重用许靖，以眩远近。",
	["$xuanhuo2"] = "给你的，十倍奉还给我！",

	["$xinzhan"] = "吾通晓兵法，世人皆知。",
	["$huilei1"] = "丞相视某如子，某以丞相为父。",
	["$huilei2"] = "谡愿以死安大局。",

	["$wuyan1"] = "唉，一切尽在不言中。",
	["$wuyan2"] = "嘘，言多必失啊……",
	["$jujian1"] = "我看好你！",
	["$jujian2"] = "将军岂愿抓牌乎？",

	["$xuanfeng1"] = "伤敌于千里之外！",
	["$xuanfeng2"] = "索命于须臾之间！",

	["$ganlu1"] = "男婚女嫁，需当交换文定之物。",
	["$ganlu2"] = "此真乃吾之佳婿也。",
	["$buyi1"] = "吾乃吴国之母，何人敢造次。",
	["$buyi2"] = "有老身在，汝等尽可放心。",

	["$pojun1"] = "大军在此！汝等休想前进一步！",
	["$pojun2"] = "敬请养精蓄锐！",

	["$xianzhen1"] = "攻无不克，战无不胜。",
	["$xianzhen2"] = "破阵斩将，易如反掌。",
	["$jinjiu1"] = "贬酒阙色，所以无污。",
	["$jinjiu2"] = "避嫌远疑，所以无误。",
	["$jiejiu1"] = "贬酒阙色，所以无污。",
	["$jiejiu2"] = "避嫌远疑，所以无误。",

	["$mingce1"] = "如此，霸业可图也！",
	["$mingce2"] = "如此，一击可擒也！",
	["$zhichi1"] = "如今之计，唯有退守，再做决断！",
	["$zhichi2"] = "若吾早知如此……",

	--武将阵亡台词
	["~caozhi"] = "本是……同根生，相煎……何太急……",
	["~yujin"] = "我……无颜面对丞相了……",
	["~zhangchunhua"] = "怎能如此对我……",
	["~fazheng"] = "蜀翼既折，蜀汉哀矣……",
	--马谡无阵亡台词,挥泪台词即为其阵亡台词
	["~xushu"] = "娘……孩儿不孝……向您……请罪……",
	["~lingtong"] = "大丈夫……不惧死亡……",
	["~wuguotai"] = "卿等……务必用心辅佐仲谋……",
	["~xusheng"] = "盛不能奋身出命，不亦辱乎…",
	["~gaoshun"] = "生死有命……",
	["~chengong"] = "请出就戮！",

	["designer:caozhi"] = "插画:b000er2010　技能:foxear",
	["designer:yujin"] = "插画:tcwin　技能:城管无畏",
	["designer:zhangchunhua"] = "插画:樱花闪乱　技能:JZHIEI",
	["designer:fazheng"] = "插画:雷没才　技能:michael_lee",
	["designer:masu"] = "插画:张帅　技能:神点点",
	["designer:xushu"] = "插画:xina0000　技能:双叶松",
	["designer:lingtong"] = "插画:绵绵　技能:奇迹之瞳",
	["designer:wuguotai"] = "插画:zoozoo　技能:章鱼咬你哦",
	["designer:xusheng"] = "插画:天空之城　技能:阿江",
	["designer:gaoshun"] = "插画:鄧Sir　技能:羽柴文理",
	["designer:chengong"] = "插画:黑月　技能:Kaycent",
}
