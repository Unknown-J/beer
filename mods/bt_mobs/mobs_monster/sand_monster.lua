local S = mobs.intllib

-- Sand Monster by PilzAdam

mobs:register_mob("mobs_monster:sand_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	--specific_attack = {"player", "mobs_npc:npc"},
	reach = 2,
	damage = 1,
	hp_min = 4,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.b3d",
	textures = {
		{"mobs_sand_monster.png"}
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sandmonster"
	},
	walk_velocity = 1.5,
	run_velocity = 4,
	view_range = 15,
	jump = true,
	floats = 0,
	drops = {
		{name = "default:desert_sand", chance = 1, min = 3, max = 5},
		{name = "mobs:leather", chance = 5, min = 0, max = 1}
	},
	water_damage = 3,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105
	},
	immune_to = {
		{"default:shovel_wood", 3}, -- shovels deal more damage to sand monster
		{"default:shovel_stone", 3},
		{"default:shovel_bronze", 4},
		{"default:shovel_steel", 4},
		{"default:shovel_mese", 5},
		{"default:shovel_diamond", 7}
	},
	on_die = function(self, pos)
		pos.y = pos.y + 0.5
		mobs:effect(pos, 30, "mobs_sand_particles.png", .1, 2, 3, 5)
		pos.y = pos.y + 0.25
		mobs:effect(pos, 30, "mobs_sand_particles.png", .1, 2, 3, 5)
	end
})

mobs:spawn({
	name = "mobs_monster:sand_monster",
	nodes = {"default:desert_sand"},
	chance = 7000,
	active_object_count = 2,
	min_height = 0
})

mobs:register_egg("mobs_monster:sand_monster", S("Sand Monster"), "default_desert_sand.png", 1)

mobs:alias_mob("mobs:sand_monster", "mobs_monster:sand_monster") -- compatibility