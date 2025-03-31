require("config.lazy")
require("config.oil")
require("config.nvim-tree")
require("config.vscode")
require("config.bufferline")
require("config.cmp")
require("config.telescope")
require("config.lspconfig")
require("config.treesitter")
require("config.undotree")
require("config.vim-fugitive")
require("config.toggleterm")
require("config.lualine")
require("config.nvim-dap")
require("config.dap-ui")
require("config.presence")
require("config.hex-view")
require("after.remap")
-- require("config.closer")

-- require("oil").setup()
--
--

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.o.showbreak = '~ '
vim.g.move_map_keys = 0;

vim.cmd('vnoremap <A-Down> <Plug>MoveBlockDown')
vim.cmd('vnoremap <A-Up>   <Plug>MoveBlockUp')
vim.cmd('nnoremap <A-Down> <Plug>MoveLineDown')
vim.cmd('nnoremap <A-Up>   <Plug>MoveLineUp')

vim.cmd('vnoremap <A-Right> <Plug>MoveBlockRight')
vim.cmd('vnoremap <A-Left>  <Plug>MoveBlockLeft')
vim.cmd('nnoremap <A-Right> <Plug>MoveCharRight')
vim.cmd('nnoremap <A-Left>  <Plug>MoveCharLeft')

vim.cmd('nnoremap <leader>ce  :edit $MYVIMRC<cr>')
vim.cmd('nnoremap <leader>cs  :source $MYVIMRC<cr>')

vim.cmd('nnoremap <leader>"  viW<esc>`>a"<esc>`<i"<esc>`>e')
vim.cmd("nnoremap <leader>'  viW<esc>`>a'<esc>`<i'<esc>`>e")

vim.cmd('vnoremap <leader>"  <esc>`>a"<esc>`<i"<esc>`>e')
vim.cmd("vnoremap <leader>'  <esc>`>a'<esc>`<i'<esc>`>e")

vim.cmd('nnoremap L  $')
vim.cmd('nnoremap H  ^')

vim.api.nvim_call_function('lexima#add_rule', {
    {char = '<', input_after = '>', filetype = 'html'}
})

vim.treesitter.language.register("glsl", "vert")
