------------------------------------------------------------------------
-- Add yanking selection keybinding (as seen on Wiki ;).              --
------------------------------------------------------------------------

local error = error
local luakit = luakit
local lousy = require("lousy")
local key, buf, but = lousy.bind.key, lousy.bind.buf
local add_binds, add_cmds = add_binds, add_cmds

module("plugins.yanksel")

add_binds("normal", {
    buf("^Y$",
	function (w)
	    local text = luakit.selection.primary
	    if not text then w:error("Empty selection.") return end
	    luakit.selection.clipboard = text
	    luakit.selection.primary = text
	    w:notify("Yanked selection:\n" .. text)
	end),
})

 
