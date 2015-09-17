cyborg_engineer_corellia = Creature:new {
	customName = "Cyborg Engineer",
	randomNameType = NAME_GENERIC_TAG,
	socialGroup = "",
	faction = "",
	level = 30,
	chanceHit = 0.33,
	damageMin = 180,
	damageMax = 190,
	baseXp = 1609,
	baseHAM = 4500,
	baseHAMmax = 5500,
	armor = 0,
	resists = {10,10,10,10,10,10,10,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = NONE,
	creatureBitmask = NONE,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/ep3/cyborg_engineer_corellia.iff"},
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang"
	--attacks = merge(brawlermaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(cyborg_engineer_corellia, "cyborg_engineer_corellia")
