minetest.register_craftitem("throwing:arrow_tnt", {
	description = "TNT Arrow",
	inventory_image = "throwing_arrow_tnt.png",
})

minetest.register_node("throwing:arrow_tnt_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"throwing_arrow_tnt.png", "throwing_arrow_tnt.png", "throwing_arrow_tnt_back.png", "throwing_arrow_tnt_front.png", "throwing_arrow_tnt_2.png", "throwing_arrow_tnt.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"throwing:arrow_tnt_box"},
	lastpos = {},
	collisionbox = {0,0,0,0,0,0}
}

local toughNodes = {
	["protector:protect"] = "protector:protect",
	["protector:protect2"] = "protector:protect2",
	["protector:chest"] = "protector:chest",
	["protector:door_wood_b_1"] = "protector:door_wood_b_1",
	["protector:door_wood_t_1"] = "protector:door_wood_t_1",
	["protector:door_wood_b_2"] = "protector:door_wood_b_2",
	["protector:door_wood_t_2"] = "protector:door_wood_t_2",
	["protector:door_steel_b_1"] = "protector:door_steel_b_1",
	["protector:door_steel_t_1"] = "protector:door_steel_t_1",
	["protector:door_steel_b_2"] = "protector:door_steel_b_2",
	["protector:door_steel_t_2"] = "protector:door_steel_t_2",
	["protector:trapdoor"] = "protector:trapdoor",
	["protector:trapdoor_steel"] = "protector:trapdoor_steel",
	["default:obsidian"] = "default:obsidian",
	["default:obsidian_block"] = "default:obsidian_block",
	["default:obsidian_glass"] = "default:obsidian_glass",
	["default:obsidianbrick"] = "default:obsidianbrick",
	["doors:door_obsidian_glass_a"] = "doors:door_obsidian_glass_a",
	["doors:door_obsidian_glass_b"] = "doors:door_obsidian_glass_b",
	["doors:door_obsidian_glass_c"] = "doors:door_obsidian_glass_c",
	["doors:door_obsidian_glass_d"] = "doors:door_obsidian_glass_d",
	["stairs:slab_obsidian"] = "stairs:slab_obsidian",
	["stairs:slab_obsidian_block"] = "stairs:slab_obsidian_block",
	["stairs:slab_obsidianbrick"] = "stairs:slab_obsidianbrick",
	["stairs:slab_obsidian"] = "stairs:slab_obsidian",
	["stairs:stair_obsidian"] = "stairs:stair_obsidian",
	["stairs:stair_obsidian_block"] = "stairs:stair_obsidian_block",
	["stairs:stair_obsidianbrick"] = "stairs:stair_obsidianbrick"
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local name = throwing.playerArrows[self.object]
	local protection_bypass = minetest.settings:get("name") == name and name or nil
	local pos = self.object:get_pos()
	local node = minetest.get_node(pos)

	if self.timer > 0.2 then
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() then
				if obj:get_luaentity().name ~= "throwing:arrow_tnt_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local extra_damage = 0
					local extra_radius = 0
					if name then
						extra_damage = ranking.playerXP[name] + math.random(0, 5)
						extra_radius = math.floor((ranking.playerXP[name] + 1) / 8) + math.random(-1, 0)
						if math.random(20) == 1 then
							extra_damage = extra_damage + math.random(5, 10)
							extra_radius = extra_radius + 1
						end
					end
					local damage = 3 + extra_damage
					if not (obj:is_player() and minetest.get_player_privs(obj:get_player_name()).server) then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
					end
					if not minetest.is_protected(pos, protection_bypass) then
						tnt.boom(pos, { radius = 3 + extra_radius, damage_radius = 5 + extra_radius, ignore_protection = false, ignore_on_blast = false })
					end
					throwing.playerArrows[self.object] = nil
					self.object:remove()
				end
			else
				local extra_damage = 0
				local extra_radius = 0
				if name then
					extra_damage = ranking.playerXP[name] + math.random(0, 5)
					extra_radius = math.floor((ranking.playerXP[name] + 1) / 8) + math.random(-1, 0)
					if math.random(20) == 1 then
						extra_damage = extra_damage + math.random(5, 10)
						extra_radius = extra_radius + 1
					end
				end
				local damage = 5 + extra_damage
				if not (obj:is_player() and minetest.get_player_privs(obj:get_player_name()).server) then
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
				end
				if not minetest.is_protected(pos, protection_bypass) then
					tnt.boom(pos, { radius = 3 + extra_radius, damage_radius = 5 + extra_radius, ignore_protection = false, ignore_on_blast = false })
				end
				throwing.playerArrows[self.object] = nil
				self.object:remove()
			end
		end
	end

	if self.lastpos.x then
		if node.name ~= "air" then
			if toughNodes[node.name] or minetest.find_node_near({x=pos.x, y=pos.y, z=pos.z}, 2, toughNodes) then
				local extra_damage = 0
				if name then
					extra_damage = ranking.playerXP[name] + math.random(0, 1)
				end
				local damage = 5 + extra_damage

				local all_objects = minetest.get_objects_inside_radius({x=self.lastpos.x, y=self.lastpos.y, z=self.lastpos.z}, 3)
				local _, obj
				for _, obj in ipairs(all_objects) do
					if not (obj:is_player() and minetest.get_player_privs(obj:get_player_name()).server) then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
					end
				end

				if not minetest.is_protected(self.lastpos, protection_bypass) then
					tnt.boom(self.lastpos, { radius = 3, damage_radius = 3, ignore_protection = false, ignore_on_blast = false })
				end
				throwing.playerArrows[self.object] = nil
				self.object:remove()
			else
				local extra_damage = 0
				local extra_radius = 0
				if name then
					extra_damage = ranking.playerXP[name] + math.random(0, 1)
					extra_radius = math.floor((ranking.playerXP[name] + 1) / 8) + math.random(-1, 0)
					if math.random(20) == 1 then
						extra_damage = extra_damage + math.random(1, 2)
						extra_radius = extra_radius + 1
					end
				end
				local damage = 1 + extra_damage

				local all_objects = minetest.get_objects_inside_radius({x=self.lastpos.x, y=self.lastpos.y, z=self.lastpos.z}, 5 + extra_radius)
				local _, obj
				for _, obj in ipairs(all_objects) do
					if not (obj:is_player() and minetest.get_player_privs(obj:get_player_name()).server) then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
					end
				end

				if not minetest.is_protected(pos, protection_bypass) then
					tnt.boom(pos, { radius = 3 + extra_radius, damage_radius = 5 + extra_radius, ignore_protection = false, ignore_on_blast = false })
				end
				throwing.playerArrows[self.object] = nil
				self.object:remove()
			end
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity("throwing:arrow_tnt_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = "throwing:arrow_tnt 1",
	recipe = {
		{"default:obsidian_shard", "default:obsidian_shard", "tnt:tnt"},
	},
	replacements = {
		{"bucket:bucket_lava", "bucket:bucket_empty"}
	}
})
