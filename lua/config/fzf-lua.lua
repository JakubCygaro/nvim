local fzf = require'fzf-lua'
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'fzf-lua find files' })
vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = 'fzf-lua resume' })
vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'fzf-lua buffers' })
vim.keymap.set('n', '<leader>ft', fzf.tabs, { desc = 'fzf-lua tabs' })
vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'fzf-lua live grep' })
vim.keymap.set('n', '<leader>fp', fzf.tmux_buffers, { desc = 'fzf-lua tmux paste buffers' })
