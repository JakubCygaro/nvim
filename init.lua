-- configuration files to load
local configs_to_load = {
    "config.lazy",
    "config.oil",
    "config.nvim-tree",
    "config.vscode",
    "config.bufferline",
    "config.cmp",
    "config.telescope",
    "config.lspconfig",
    "config.treesitter",
    "config.undotree",
    "config.vim-fugitive",
    "config.toggleterm",
    "config.lualine",
    "config.nvim-dap",
    "config.dap-ui",
    "config.neocord",
    "config.hex-view",
    "config.lsp-signature",
    "after.remap",
}

for _, v in ipairs(configs_to_load) do
    -- load each file via pcall so that if one plugin fails to configure that won't fuck up the whole neovim configuraton process
    local status, err = pcall(require, v)
    if not status then
        print("Error while loading configuration file: " .. v .. "\n" .. err)
    end
end

vim.opt.number = true  -- turn on line numbers
vim.opt.relativenumber = true -- turn on relative line numbering
vim.opt.signcolumn = "number"
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting
vim.o.showbreak = '~ ' -- character for wrapped lines
vim.g.move_map_keys = 0;

vim.keymap.set("n", "<leader>ce", ":edit $MYVIMRC<CR>", {
    desc = "Edit the init.lua file in a new buffer"
})
vim.keymap.set("n", "<leader>cs", ":source $MYVIMRC<cr>", {
    desc = "Source the init.lua file (reload configuration)"
})
vim.keymap.set("n", '<leader>"', 'viW<esc>`>a"<esc>`<i"<esc>`>e', {
    desc = 'Surrond WORD with " '
})
vim.keymap.set("n", "<leader>'", "viW<esc>`>a'<esc>`<i'<esc>`>e", {
    desc = "Surrond WORD with ' "
})
vim.keymap.set("n", "<leader>*", "viW<esc>`>a*<esc>`<i*<esc>`>e", {
    desc = "Surrond WORD with * "
})

-- creates a visual mode mapping that surrounds visual mode selection with a character,
-- optionally using a different closing character if such was provided
local function gen_surround_keymap(character, closing)
    local description = "Surround visual selection with '" .. character .. "'";
    if closing ~= nil then
        description = description .. " and closed by '" .. closing .. "'"
    end
    if closing ~= nil then
        vim.keymap.set("v", "<leader>" .. closing, function()
            return "<esc>`>" ..
                vim.v.count1 .. "a" .. closing .. "<esc>`<" .. vim.v.count1 .. "i" .. character .. "<esc>`>e";
        end, { expr = true, desc = description})
    end
    closing = closing or character;
    vim.keymap.set("v", "<leader>" .. character, function()
        return "<esc>`>" .. vim.v.count1 .. "a" .. closing .. "<esc>`<" .. vim.v.count1 .. "i" .. character .. "<esc>`>e";
    end, { expr = true, desc = description})
end

-- characters for visual mode surrounding
local surround = { '*', "'", '"', '_',
    { character = '(', closing = ')' },
    { character = '{', closing = '}' },
    { character = '[', closing = ']' },
    { character = '<', closing = '>' },
}
local function gen_surrounds(chars)
    for _, v in ipairs(chars) do
        if type(v) == "string" then
            gen_surround_keymap(v, nil)
        end
        if type(v) == "table" then
            if v.character ~= nil and v.closing ~= nil then
                gen_surround_keymap(v.character, v.closing)
            else
                error("invalid object passed to gen_surrounds")
            end
        end
    end
end
gen_surrounds(surround)

vim.keymap.set("n", "L", "$", {
    desc = "Change the default behavior of L to the behavior of $"
})
vim.keymap.set("n", "H", "^", {
    desc = "Change the default behavior of H to the behavior of ^"
})


-- add glsl recognition for treesitter for files with .vert extension
vim.treesitter.language.register("glsl", "vert")

-- highlight trailing whitespace
vim.cmd("match DiffDelete /\\v +$/")

vim.keymap.set("n", "<leader>cd", "<cmd>:cd %:p:h<CR>", {
    desc = "Change the working directory to that of the file open in the current buffer"
})

--diagnostics
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
vim.opt.signcolumn = 'yes:1'

--quickfix specific
vim.keymap.set("n", "<leader>qo", "<cmd>:copen<CR>", {
    desc = "Open quickfix window"
})
vim.keymap.set("n", "<leader>qq", "<cmd>:cclose<CR>", {
    desc = "Close quickfix window"
})
vim.keymap.set("n", "<leader>qj", "<cmd>:cnext<CR>", {
    desc = "Quickfix next"
})
vim.keymap.set("n", "<leader>qk", "<cmd>:cp<CR>", {
    desc = "Quickfix previous"
})
