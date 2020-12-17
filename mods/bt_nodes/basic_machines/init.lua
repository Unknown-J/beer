-- BASIC_MACHINES: lightweight automation mod for minetest
-- minetest 0.4.14
-- (c) 2015-2016 rnd

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.


basic_machines = {}

local MP = minetest.get_modpath("basic_machines") .. "/"

dofile(MP .. "mark.lua") -- used for markings, borrowed and adapted from worldedit mod
dofile(MP .. "mover.lua") -- mover, detector, keypad, distributor
dofile(MP .. "technic_power.lua") -- technic power for mover
dofile(MP .. "recycler.lua") -- recycle old used tools
dofile(MP .. "grinder.lua") -- grind materials into dusts
dofile(MP .. "autocrafter.lua") -- borrowed and adapted from pipeworks mod
dofile(MP .. "constructor.lua") -- enable crafting of basic machines
dofile(MP .. "electronics_constructor.lua") -- enable crafting of small electronic devices
dofile(MP .. "digtron_constructor.lua") -- enable crafting of digtron units

dofile(MP .. "protect.lua") -- enable interaction with players, adds local on protect/chat event handling

-- OPTIONAL ADDITIONAL STUFF ( comment to disable )

dofile(MP .. "ball.lua") -- interactive flying ball, can activate blocks or be used as a weapon
dofile(MP .. "enviro.lua") -- enviro blocks that can change surrounding enviroment physics, uncomment spawn/join code to change global physics, disabled by default
dofile(MP .. "mesecon_doors.lua") -- if you want open/close doors with signal, also steel doors are made impervious to dig through, removal by repeat punch
minetest.after(0, function()
	dofile(MP .. "mesecon_lights.lua") -- adds ability for other light blocks to toggle light
end)


-- MACHINE PRIVILEGE
minetest.register_privilege("machines", {
	description = "Player is expert basic_machine user: his machines work while not present on server, can spawn more than 2 balls at once",
})

-- machines fuel related recipes
-- CHARCOAL

minetest.register_craftitem("basic_machines:charcoal", {
	description = "Wood Charcoal",
	inventory_image = "charcoal.png"
})

minetest.register_craft({
	type = "cooking",
	output = "basic_machines:charcoal",
	recipe = "group:tree",
	cooktime = 30
})

minetest.register_craft({
	output = "default:coal_lump",
	recipe = {
		{"basic_machines:charcoal"},
		{"basic_machines:charcoal"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "basic_machines:charcoal",
	-- note: to make it you need to use 1 tree block for fuel + 1 tree block, thats 2, caloric value 2*30=60
	burntime = 40 -- coal lump has 40, tree block 30, coal block 370 (9*40=360!)
})

minetest.register_craftitem("basic_machines:control_logic_unit", {
	description = "Control Logic Unit",
	inventory_image = "basic_machines_control_logic_unit.png"
})


-- COMPATIBILITY
print("[MOD] basic_machines " .. basic_machines.version .. " loaded.")