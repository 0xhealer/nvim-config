if vim.loader then
  vim.loader.enable()
end

require("core.options")
require("core.autocmds")
require("core.keymaps")
require("core.commands")
require("utils")
require("plugins")
