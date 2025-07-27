vim.g.mapleader = " "
vim.keymap.set("n", "<leader>rn", function ()
    vim.o.relativenumber = not vim.o.relativenumber;
end)
--Oil
vim.keymap.set("n", "<leader>oo", vim.cmd.Oil)
-- :nohl
vim.keymap.set("n", "<leader>nh", "<cmd>:nohl<CR>")
-- nvim-tree
vim.keymap.set("n", "<leader>nt", "<cmd>:NvimTreeToggle<CR>")
-- BufferLine
vim.keymap.set("n", "<leader>ll", "<cmd>:BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>hh", "<cmd>:BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>:BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>bc", "<cmd>:BufferLinePickClose<CR>")
vim.keymap.set("n", "<leader>bp", "<cmd>:BufferLinePick<CR>")
vim.keymap.set("n", "<leader>bdl", "<cmd>:BufferLineCloseRight<CR>")
vim.keymap.set("n", "<leader>bdh", "<cmd>:BufferLineCloseLeft<CR>")
vim.keymap.set("n", "<leader>bdj", "<cmd>:BufferLineCloseOthers<CR>")
-- ToggleTerm
vim.keymap.set("n", "<leader>tt", function ()
    return vim.v.count .. ':ToggleTerm<CR>'
end, {expr = true})
vim.keymap.set("n", "<leader>ts", ':TermSelect<CR>')
vim.keymap.set("n", "<leader>tn", function ()
    return vim.v.count .. ':ToggleTermSetName<CR>'
end, {expr = true})
-- ToggleTerm manager
vim.keymap.set("n", "<leader>tm", "<cmd>:Telescope toggleterm_manager<CR>")

vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp
-- DAP
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dL', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
vim.keymap.set('n', '<Leader>dt', function ()
    require('dapui').toggle()
end)
-- hex view
vim.keymap.set("n", "<leader>hv", "<cmd>:HexToggle<CR>")


--diagnostics filtering
local function set_diangnostics_keymap(lhs, level)
    local dfilter = require("after.filter_diagnostics")
    vim.keymap.set('n', lhs, function()
        dfilter.set_level(level)
    end,
    { desc = "set diagnostic filter to " .. level }
    )
end
-- diagnostics filtering keybinds
set_diangnostics_keymap("<leader>E", vim.diagnostic.severity.ERROR)
set_diangnostics_keymap("<leader>W", vim.diagnostic.severity.WARN)
set_diangnostics_keymap("<leader>I", vim.diagnostic.severity.INFO)
set_diangnostics_keymap("<leader>H", vim.diagnostic.severity.HINT)
vim.keymap.set("n", "<leader>D", function ()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- compile mode
local compile_mode = require'compile-mode';

vim.keymap.set('n', '<Leader>cc', function()
    compile_mode.compile(nil);
end)

vim.keymap.set('n', '<Leader>cr', function()
    compile_mode.recompile(nil);
end)

vim.keymap.set('n', '<Leader>cq', function()
    compile_mode.close_buffer();
end)
vim.keymap.set('n', '<Leader>cj', function()
    compile_mode.next_error();
end)
vim.keymap.set('n', '<Leader>ck', function()
    compile_mode.prev_error();
end)
