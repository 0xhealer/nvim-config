-- Multiple cursors, VSCode-style: add cursors, then type/edit once and it
-- applies to all of them simultaneously (unlike smoka7/multicursors.nvim's
-- enter-a-mode-then-batch-apply workflow, which is a different, more Vim-
-- native design). Following the plugin's own documented example config.
local mc = require("multicursor-nvim")
mc.setup()

local set = vim.keymap.set

-- Add or skip a cursor directly above/below the current one -- matches
-- VSCode's Ctrl+Alt+Up/Down (using just Ctrl here, not Ctrl+Alt -- that
-- combo isn't reliably sent as a distinct sequence by every terminal,
-- especially on Windows). Bare Up/Down were tried first and reverted:
-- they silently ate normal arrow-key navigation, so every plain up/down
-- press added a cursor instead of just moving -- not what "invoke it
-- when I want it" means.
set({ "n", "x" }, "<c-up>", function()
	mc.lineAddCursor(-1)
end, { desc = "Add cursor above" })
set({ "n", "x" }, "<c-down>", function()
	mc.lineAddCursor(1)
end, { desc = "Add cursor below" })
set({ "n", "x" }, "<leader><up>", function()
	mc.lineSkipCursor(-1)
end, { desc = "Skip line, add cursor above" })
set({ "n", "x" }, "<leader><down>", function()
	mc.lineSkipCursor(1)
end, { desc = "Skip line, add cursor below" })

-- Add or skip a cursor on the next/previous match of the word under the
-- cursor (or the current selection) -- matches VSCode's Ctrl+D. Key choices
-- match the plugin's own documented example exactly.
set({ "n", "x" }, "<leader>n", function()
	mc.matchAddCursor(1)
end, { desc = "Add cursor on next match" })
set({ "n", "x" }, "<leader>N", function()
	mc.matchAddCursor(-1)
end, { desc = "Add cursor on previous match" })
set({ "n", "x" }, "<leader>s", function()
	mc.matchSkipCursor(1)
end, { desc = "Skip match, find next" })
set({ "n", "x" }, "<leader>S", function()
	mc.matchSkipCursor(-1)
end, { desc = "Skip match, find previous" })

-- Add/remove cursors with Ctrl+click, matching VSCode's Alt+click (Ctrl
-- instead, since Alt-click is already claimed by window-manager conventions
-- on most desktops and wouldn't reach the terminal).
set("n", "<c-leftmouse>", mc.handleMouse)
set("n", "<c-leftdrag>", mc.handleMouseDrag)
set("n", "<c-leftrelease>", mc.handleMouseRelease)

-- Esc: enable/clear multi-cursors. Wrapped in addKeymapLayer (the plugin's
-- own documented pattern for this) so it ONLY takes effect while multiple
-- cursors actually exist -- normal <Esc> behavior is completely untouched
-- the rest of the time.
mc.addKeymapLayer(function(layerSet)
	layerSet({ "n", "x" }, "<left>", mc.prevCursor)
	layerSet({ "n", "x" }, "<right>", mc.nextCursor)
	layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)
	layerSet("n", "<esc>", function()
		if not mc.cursorsEnabled() then
			mc.enableCursors()
		else
			mc.clearCursors()
		end
	end)
end)
