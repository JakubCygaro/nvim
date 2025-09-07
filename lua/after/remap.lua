-- map the leader character to SPACE
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>rn", function()
    vim.o.relativenumber = not vim.o.relativenumber;
end, {
    desc = "Toggle relative line numbering"
})
--Oil
vim.keymap.set("n", "<leader>oo", vim.cmd.Oil, { desc = "Open Oil" })
-- :nohl
vim.keymap.set("n", "<leader>nh", "<cmd>:nohl<CR>", {
    desc = "Turn after search highlighting off"
})
-- nvim-tree
vim.keymap.set("n", "<leader>nt", "<cmd>:NvimTreeToggle<CR>", {
    desc = "Open Nvim Tree"
})
-- BufferLine
vim.keymap.set("n", "<leader>ll", "<cmd>:BufferLineCycleNext<CR>", {
    desc = "Switch to buffer on the right"
})
vim.keymap.set("n", "<leader>hh", "<cmd>:BufferLineCyclePrev<CR>", {
    desc = "Switch to buffer on the left"
})
vim.keymap.set("n", "<Tab>", "<cmd>:BufferLineCycleNext<CR>", {
    desc = "Cycle to the next buffer"
})
vim.keymap.set("n", "<S-Tab>", "<cmd>:BufferLineCyclePrev<CR>", {
    desc = "Cycle to the previous buffer"
})
vim.keymap.set("n", "<leader>bc", "<cmd>:BufferLinePickClose<CR>", {
    desc = "Pick a buffer to close"
})
vim.keymap.set("n", "<leader>bp", "<cmd>:BufferLinePick<CR>", {
    desc = "Pick a buffer to open"
})
vim.keymap.set("n", "<leader>bdl", "<cmd>:BufferLineCloseRight<CR>", {
    desc = "Close all buffer to the right of the current"
})
vim.keymap.set("n", "<leader>bdh", "<cmd>:BufferLineCloseLeft<CR>", {
    desc = "Close all buffer to the left of the current"
})
vim.keymap.set("n", "<leader>bdj", "<cmd>:BufferLineCloseOthers<CR>", {
    desc = "Close all buffers except the current one"
})
-- ToggleTerm
vim.keymap.set("n", "<leader>tt", function()
    return vim.v.count .. ':ToggleTerm<CR>'
end, { expr = true, desc = "Open a terminal, accepts a number if you want to open a new one" })
vim.keymap.set("n", "<leader>ts", ':TermSelect<CR>', {
    desc = "Select a terminal to open"
})
vim.keymap.set("n", "<leader>tn", function()
    return vim.v.count .. ':ToggleTermSetName<CR>'
end, { expr = true, desc = "Set a name for a terminal" })
-- ToggleTerm manager
vim.keymap.set("n", "<leader>tm", "<cmd>:Telescope toggleterm_manager<CR>", {
    desc = "Find a terminal with Telescope"
})

vim.keymap.set('c', '<tab>', '<C-z>', { silent = false }) -- to fix cmp
-- DAP
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, {
    desc = "Start a debugger session"
})
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, {
    desc = "(Debugging) Step over"
})
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, {
    desc = "(Debugging) Step into"
})
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, {
    desc = "(Debugging) Step out"
})
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, {
    desc = "(Debugging) Toggle breakpoint on current line"
})
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end, {
    desc = "(Debugging) Set breakpoint on current line"
})
vim.keymap.set('n', '<Leader>dL',
    function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {
    desc = "(Debugging) Set breakpoint with log message"
})
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, {
    desc = "(Debugging) Open repl"
})
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, {
    desc = "(Debugging) Run last"
})
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
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
vim.keymap.set('n', '<Leader>dt', function()
    require('dapui').toggle()
end, {
    desc = "(Debugging) Toggle UI"
})
-- hex view
vim.keymap.set("n", "<leader>hv", "<cmd>:HexToggle<CR>", {
    desc = "Toggle Hexview"
})


--diagnostics filtering
local function set_diangnostics_keymap(lhs, level)
    local dfilter = require("after.filter_diagnostics")
    vim.keymap.set('n', lhs, function()
            dfilter.set_level(level)
        end,
        { desc = "Set diagnostic filter to " .. level }
    )
end
-- diagnostics filtering keybinds
set_diangnostics_keymap("<leader>E", vim.diagnostic.severity.ERROR)
set_diangnostics_keymap("<leader>W", vim.diagnostic.severity.WARN)
set_diangnostics_keymap("<leader>I", vim.diagnostic.severity.INFO)
set_diangnostics_keymap("<leader>H", vim.diagnostic.severity.HINT)
vim.keymap.set("n", "<leader>D", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)

-- compile mode
local compile_mode = require 'compile-mode';

vim.keymap.set('n', '<Leader>cc', ':belowright :silent :Compile<CR>', {
    desc = "Open compile mode with provided command"
})

vim.keymap.set('n', '<Leader>cr', ':belowright :silent :Recompile<CR>', {
    desc = "Rerun compile mode with previous command"
})

vim.keymap.set('n', '<Leader>cq', function()
    compile_mode.close_buffer();
end, {
    desc = "Quit compile mode"
})
vim.keymap.set('n', '<Leader>cj', function()
    compile_mode.next_error();
end, {
    desc = "Jump to next error in compile mode"
})
vim.keymap.set('n', '<Leader>ck', function()
    compile_mode.prev_error();
end, {
    desc = "Jump to previous erron in compile mode"
})
