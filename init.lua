require("config.lazy")
require("config.oil")
require("config.mini")
require("config.vscode")
require("config.cmp")
require("config.telescope")
require("config.lspconfig")
require("config.treesitter")
-- require("config.closer")

-- require("oil").setup()
--
--

vim.opt.number = true
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.api.nvim_call_function('lexima#add_rule', {
    {char = '<', input_after = '>'}
})
