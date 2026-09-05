-- Show "REC @<register>" while a macro is being recorded.
local function statusline_recording()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "REC @" .. reg
end

-- Flag when ':ToggleFormatter' (core/commands.lua) has turned off
-- format-on-save for this buffer -- otherwise that state is invisible
-- once the vim.notify from the command scrolls out of view.
local function statusline_autofmt()
	if vim.b.disable_autoformat then
		return "fmt-off"
	end
	return ""
end

-- Neovim 0.12's LSP progress status (e.g. while a server is indexing).
-- Wrapped defensively: no-ops on any Neovim build where this API differs
-- or isn't present, rather than erroring the statusline.
local function statusline_lsp_progress()
	local ok, status = pcall(vim.ui.progress_status)
	if not ok or type(status) ~= "string" or status == "" then
		return ""
	end
	return status
end

-- Flag when the current buffer is a Snacks floating/split terminal
-- (plugins/keymaps.lua's <leader>tt) -- otherwise a terminal buffer looks
-- just like any other buffer in the statusline, easy to lose track of
-- amid the new bufferline tabs above.
local function statusline_terminal()
	if vim.bo.filetype == "snacks_terminal" then
		return "TERM"
	end
	return ""
end

-- Filetype icon (mini.icons) + filename, as one segment so the icon always
-- sits directly next to the name it belongs to, not as a separate column
-- that could drift out of alignment with it at narrow widths.
local function statusline_filename_with_icon()
	local icon = ""
	local ok, icon_glyph = pcall(function()
		return (MiniIcons.get("filetype", vim.bo.filetype))
	end)
	if ok and icon_glyph and icon_glyph ~= "" then
		icon = icon_glyph .. " "
	end
	return icon .. MiniStatusline.section_filename({ trunc_width = 140 })
end

require("mini.statusline").setup({
	use_icons = true,
	content = {
		-- Same structure as MiniStatusline's own default (see
		-- `:h MiniStatusline-example-content`), with four extra sections
		-- spliced in: macro recording, autoformat-off flag, LSP progress,
		-- terminal-buffer flag. Filename now sits in its own centered
		-- section (two "%=" markers, one on each side) rather than
		-- left-aligned with everything else.
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

			local recording = statusline_recording()
			local autofmt = statusline_autofmt()
			local progress = statusline_lsp_progress()
			local terminal = statusline_terminal()
			local filename_with_icon = statusline_filename_with_icon()

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode, recording, terminal } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
				"%=", -- Start center alignment
				"%<", -- Truncate point -- long paths shrink from here, not the edges
				{ hl = "MiniStatuslineFilename", strings = { filename_with_icon } },
				"%=", -- End center alignment, begin right alignment
				{ hl = "DiagnosticWarn", strings = { autofmt } },
				{ hl = "MiniStatuslineDevinfo", strings = { progress } },
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { search, location } },
			})
		end,
	},
})
