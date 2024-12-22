vim.g.mapleader = " "
vim.keymap.set("n", "<leader>rn", function ()
    vim.o.relativenumber = not vim.o.relativenumber;
end)
--Oil
vim.keymap.set("n", "<leader>pv", vim.cmd.Oil)
-- :nohl
vim.keymap.set("n", "<leader>nh", "<cmd>:nohl<CR>")
-- nvim-tree
vim.keymap.set("n", "<leader>nt", "<cmd>:NvimTreeToggle<CR>")
-- BufferLine
vim.keymap.set("n", "<leader><Right><Right>", "<cmd>:BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader><Left><Left>", "<cmd>:BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>:BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bd", "<cmd>:BufferLinePickClose<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>:BufferLinePick<CR>")
vim.keymap.set("n", "<leader>d<Right>", "<cmd>:BufferLineCloseRight<CR>")
vim.keymap.set("n", "<leader>d<Left>", "<cmd>:BufferLineCloseLeft<CR>")
vim.keymap.set("n", "<leader>d<Up>", "<cmd>:BufferLineCloseOthers<CR>")
-- ToggleTerm
vim.keymap.set("n", "<leader>tt", function ()
    return vim.v.count .. ':ToggleTerm<CR>'
end, {expr = true})
vim.keymap.set("n", "<leader>ts", ':TermSelect<CR>')
vim.keymap.set("n", "<leader>tn", function ()
    return vim.v.count .. ':ToggleTermSetName<CR>'
end, {expr = true})

vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp
