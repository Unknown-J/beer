local path = minetest.get_modpath("mobs") .. "/"

-- Mob API
dofile(path .. "api.lua")

-- Rideable Mobs
dofile(path .. "mount.lua")

-- Mob Items
dofile(path .. "crafts.lua")

-- Mob Spawner
dofile(path .. "spawner.lua")

minetest.log("action", "[MOD] Mobs Redo loaded")