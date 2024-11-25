vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
vim.keymap.set("n", "<leader>nh", "<cmd>:nohl<CR>")
vim.keymap.set("n", "<leader><Right><Right>", "<cmd>:BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader><Left><Left>", "<cmd>:BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>:BufferLinePickClose<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>:BufferLinePick<CR>")
vim.keymap.set("n", "<leader>d<Right>", "<cmd>:BufferLineCloseRight<CR>")
vim.keymap.set("n", "<leader>d<Left>", "<cmd>:BufferLineCloseLeft<CR>")
vim.keymap.set("n", "<leader>d<Up>", "<cmd>:BufferLineCloseOthers<CR>")

--function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
--end
-- _G.set_terminal_keymaps()
--vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
