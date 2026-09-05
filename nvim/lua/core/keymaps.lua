local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

keymap("n", "x", '"_x', { desc = "Delete char (no yank)" })
keymap("n", "<Leader>p", '"0p', { desc = "Paste after (no yank)" })
keymap("n", "<Leader>P", '"0P', { desc = "Paste before (no yank)" })
keymap("v", "<Leader>p", '"0p', { desc = "Paste over selection (no yank)" })
keymap("n", "<Leader>c", '"_c', { desc = "Change (no yank)" })
keymap("n", "<Leader>C", '"_C', { desc = "Change to end of line (no yank)" })
keymap("v", "<Leader>c", '"_c', { desc = "Change selection (no yank)" })
keymap("v", "<Leader>C", '"_C', { desc = "Change to end of line (no yank)" })
keymap("n", "<Leader>d", '"_d', { desc = "Delete (no yank)" })
keymap("n", "<Leader>D", '"_D', { desc = "Delete to end of line (no yank)" })
keymap("v", "<Leader>d", '"_d', { desc = "Delete selection (no yank)" })
keymap("v", "<Leader>D", '"_D', { desc = "Delete to end of line (no yank)" })

keymap("n", "+", "<C-a>", { desc = "Increment number" })
keymap("n", "-", "<C-x>", { desc = "Decrement number" })

keymap("n", "dw", 'vb"_d', { desc = "Delete word backwards (no yank)" })
keymap("n", "dW", "dw", { noremap = true, silent = true, desc = "Delete word forward (vanilla dw)" })

keymap("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

keymap("n", "<Leader>o", "o<Esc>^Da", vim.tbl_extend("force", opts, { desc = "New line below (no comment continuation)" }))
keymap("n", "<Leader>O", "O<Esc>^Da", vim.tbl_extend("force", opts, { desc = "New line above (no comment continuation)" }))

keymap("n", "<C-m>", "<C-i>", vim.tbl_extend("force", opts, { desc = "Jumplist forward" }))

keymap("n", "te", ":tabedit<CR>", { desc = "New tab" })
keymap("n", "<tab>", ":tabnext<CR>", vim.tbl_extend("force", opts, { desc = "Next tab" }))
keymap("n", "<s-tab>", ":tabprev<CR>", vim.tbl_extend("force", opts, { desc = "Previous tab" }))
keymap("n", "ss", ":split<Return>", vim.tbl_extend("force", opts, { desc = "Split window horizontally" }))
keymap("n", "sv", ":vsplit<Return>", vim.tbl_extend("force", opts, { desc = "Split window vertically" }))
keymap("n", "sh", "<C-w>h", { desc = "Move to left window" })
keymap("n", "sk", "<C-w>k", { desc = "Move to window above" })
keymap("n", "sj", "<C-w>j", { desc = "Move to window below" })
keymap("n", "sl", "<C-w>l", { desc = "Move to right window" })

-- If the buffer has no name yet (a brand-new `enew`/<C-n> buffer), plain
-- :w always fails with "E32: No file name" -- it never prompts on its own,
-- unlike what I said earlier. This prompts for a path instead of erroring.
local function save_file()
	if vim.fn.expand("%") == "" then
		vim.ui.input({ prompt = "Save as: " }, function(name)
			if name and name ~= "" then
				vim.cmd("write " .. vim.fn.fnameescape(name))
			end
		end)
	else
		vim.cmd("write")
	end
end

keymap("n", "<C-s>", save_file, vim.tbl_extend("force", opts, { desc = "Save file" }))
keymap("i", "<C-s>", function()
	vim.cmd("stopinsert")
	save_file()
end, vim.tbl_extend("force", opts, { desc = "Save file" }))

keymap("n", "<leader>q", ":q<CR>", vim.tbl_extend("force", opts, { desc = "Quit" }))
keymap("n", "<leader>wq", ":wq!<CR>", vim.tbl_extend("force", opts, { desc = "Force save and quit" }))

keymap("n", "<M-Down>", ":m .+1<CR>==", vim.tbl_extend("force", opts, { desc = "Move line down" }))
keymap("n", "<M-Up>", ":m .-2<CR>==", vim.tbl_extend("force", opts, { desc = "Move line up" }))
keymap("i", "<M-Down>", "<Esc>:m .+1<CR>==gi", vim.tbl_extend("force", opts, { desc = "Move line down" }))
keymap("i", "<M-Up>", "<Esc>:m .-2<CR>==gi", vim.tbl_extend("force", opts, { desc = "Move line up" }))
keymap("v", "<M-Down>", ":m '>+1<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection down" }))
keymap("v", "<M-Up>", ":m '<-2<CR>gv=gv", vim.tbl_extend("force", opts, { desc = "Move selection up" }))

keymap("n", "<leader>i", function() end, { desc = "Toggle inlay hints (not implemented)" })

keymap("n", "<leader>yf", function()
	require("utils.editor").yank_relative_path_with_line()
end, { desc = "Yank relative path with line number" })

keymap("n", "<leader>yp", function()
	require("utils.editor").yank_absolute_path_with_line()
end, { desc = "Yank absolute path with line number" })

keymap("v", "<leader>cb", ":<C-u>lua require('utils.editor').copy_as_codeblock()<CR>", { desc = "Copy selection as markdown codeblock" })

keymap("n", "<leader>j", function()
	require("utils.editor").open_package_json()
end, { desc = "Open package.json in floating window" })

keymap("n", "<leader>bd", function()
	require("utils.editor").delete_hidden_buffers()
end, { desc = "Delete hidden buffers" })
