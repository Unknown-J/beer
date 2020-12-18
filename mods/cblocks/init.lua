local colours = {
	{"black",      "Black",      "#000000b0"},
	{"blue",       "Blue",       "#015dbb70"},
	{"brown",      "Brown",      "#a78c4570"},
	{"cyan",       "Cyan",       "#01ffd870"},
	{"dark_green", "Dark Green", "#005b0770"},
	{"dark_grey",  "Dark Grey",  "#303030b0"},
	{"green",      "Green",      "#61ff0170"},
	{"grey",       "Grey",       "#5b5b5bb0"},
	{"magenta",    "Magenta",    "#ff05bb70"},
	{"orange",     "Orange",     "#ff840170"},
	{"pink",       "Pink",       "#ff65b570"},
	{"red",        "Red",        "#ff000070"},
	{"violet",     "Violet",     "#2000c970"},
	{"white",      "White",      "#abababc0"},
	{"yellow",     "Yellow",     "#e3ff0070"},
}

for i = 1, #colours, 1 do

-- wood

minetest.register_node("cblocks:wood_" .. colours[i][1], {
	description = colours[i][2] .. " Wooden Planks",
	tiles = {"default_wood.png^[colorize:" .. colours[i][3]},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "cblocks:wood_".. colours[i][1] .. " 2",
	recipe = {
		{"group:wood","group:wood", "dye:" .. colours[i][1]},
	}
})

-- stone brick

minetest.register_node("cblocks:stonebrick_" .. colours[i][1], {
	description = colours[i][2] .. " Stone Brick",
	tiles = {"default_stone_brick.png^[colorize:" .. colours[i][3]},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "cblocks:stonebrick_".. colours[i][1] .. " 2",
	recipe = {
		{"default:stonebrick","default:stonebrick", "dye:" .. colours[i][1]},
	}
})

-- glass

minetest.register_node( "cblocks:glass_" .. colours[i][1], {
	description = colours[i][2] .. " Glass",
	tiles = {"cblocks.png^[colorize:" .. colours[i][3]},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	use_texture_alpha = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "cblocks:glass_".. colours[i][1] .. " 2",
	recipe = {
		{"default:glass","default:glass", "dye:" .. colours[i][1]},
	}
})

-- brick block

minetest.register_node("cblocks:brick_" .. colours[i][1], {
	description = colours[i][2] .. " Brick Block",
	tiles = {"default_brick.png^[colorize:" .. colours[i][3]},
	is_ground_content = false,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "cblocks:brick_".. colours[i][1] .. " 2",
	recipe = {
		{"default:brick","default:brick", "dye:" .. colours[i][1]},
	}
})

-- cobblestone

minetest.register_node("cblocks:cobble_" .. colours[i][1], {
	description = colours[i][2] .. " Cobblestone",
	tiles = {"default_cobble.png^[colorize:" .. colours[i][3]},
	is_ground_content = false,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "cblocks:cobble_".. colours[i][1] .. " 2",
	recipe = {
		{"default:cobble","default:cobble", "dye:" .. colours[i][1]},
	}
})

-- stone

minetest.register_node("cblocks:stone_" .. colours[i][1], {
	description = colours[i][2] .. " Stone",
	tiles = {"default_stone.png^[colorize:" .. colours[i][3]},
	is_ground_content = false,
	groups = {cracky = 3, stone = 1},
	drop = 'cblocks:cobble_' .. colours[i][1],
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "cblocks:stone_".. colours[i][1] .. " 2",
	recipe = {
		{"default:stone","default:stone", "dye:" .. colours[i][1]},
	}
})

-- steel block

minetest.register_node("cblocks:steelblock_" .. colours[i][1], {
	description = colours[i][2] .. " Steel Block",
	tiles = {"default_steel_block.png^[colorize:" .. colours[i][3]},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "cblocks:steelblock_".. colours[i][1] .. " 2",
	recipe = {
		{"default:steelblock","default:steelblock", "dye:" .. colours[i][1]},
	}
})

-- fence

local fence_texture =
	"default_fence_overlay.png^default_wood.png^[colorize:" .. colours[i][3] .. "^default_fence_overlay.png^[makealpha:255,126,126"
minetest.register_node("cblocks:fence_wood_" .. colours[i][1], {
	description = colours[i][2] .. " Fence",
	drawtype = "fencelike",
	tiles = {"default_wood.png^[colorize:" .. colours[i][3]},
	inventory_image = fence_texture,
	wield_image = fence_texture,
	paramtype = "light",
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "cblocks:fence_wood_".. colours[i][1] .. " 2",
	recipe = {
		{"default:fence_wood","default:fence_wood", "dye:" .. colours[i][1]},
	}
})
