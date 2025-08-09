local status, err = true, nil
status, err = pcall(require, "config.lazy")
if not status then
    print("Error while loading configuration file: " .. "config.lazy" .. "\n" .. err)
end
status, err = pcall(require, "config.oil")
if not status then
    print("Error while loading configuration file: " .. "config.oil" .. "\n" .. err)
end
status, err = pcall(require, "config.nvim-tree")
if not status then
    print("Error while loading configuration file: " .. "config.nvim-tree" .. "\n" .. err)
end
status, err = pcall(require, "config.vscode")
if not status then
    print("Error while loading configuration file: " .. "config.vscode" .. "\n" .. err)
end
status, err = pcall(require, "config.bufferline")
if not status then
    print("Error while loading configuration file: " .. "config.bufferline" .. "\n" .. err)
end
status, err = pcall(require, "config.cmp")
if not status then
    print("Error while loading configuration file: " .. "config.cmp" .. "\n" .. err)
end
status, err = pcall(require, "config.telescope")
if not status then
    print("Error while loading configuration file: " .. "config.telescope" .. "\n" .. err)
end
status, err = pcall(require, "config.lspconfig")
if not status then
    print("Error while loading configuration file: " .. "config.lspconfig" .. "\n" .. err)
end
status, err = pcall(require, "config.treesitter")
if not status then
    print("Error while loading configuration file: " .. "config.treesitter" .. "\n" .. err)
end
status, err = pcall(require, "config.undotree")
if not status then
    print("Error while loading configuration file: " .. "config.undotree" .. "\n" .. err)
end
status, err = pcall(require, "config.vim-fugitive")
if not status then
    print("Error while loading configuration file: " .. "config.vim-fugitive" .. "\n" .. err)
end
status, err = pcall(require, "config.toggleterm")
if not status then
    print("Error while loading configuration file: " .. "config.toggleterm" .. "\n" .. err)
end
status, err = pcall(require, "config.lualine")
if not status then
    print("Error while loading configuration file: " .. "config.lualine" .. "\n" .. err)
end
status, err = pcall(require, "config.nvim-dap")
if not status then
    print("Error while loading configuration file: " .. "config.nvim-dap" .. "\n" .. err)
end
status, err = pcall(require, "config.dap-ui")
if not status then
    print("Error while loading configuration file: " .. "config.dap-ui" .. "\n" .. err)
end
status, err = pcall(require, "config.neocord")
if not status then
    print("Error while loading configuration file: " .. "config.neocord" .. "\n" .. err)
end
status, err = pcall(require, "config.hex-view")
if not status then
    print("Error while loading configuration file: " .. "config.hex-view" .. "\n" .. err)
end
status, err = pcall(require, "config.lsp-signature")
if not status then
    print("Error while loading configuration file: " .. "config.lsp-signature" .. "\n" .. err)
end
status, err = pcall(require, "after.remap")
if not status then
    print("Error while loading configuration file: " .. "after.remap" .. "\n" .. err)
end

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting
vim.o.showbreak = '~ '
vim.g.move_map_keys = 0;

vim.cmd('nnoremap <leader>ce  :edit $MYVIMRC<cr>')
vim.cmd('nnoremap <leader>cs  :source $MYVIMRC<cr>')

vim.cmd('nnoremap <leader>"  viW<esc>`>a"<esc>`<i"<esc>`>e')
vim.cmd("nnoremap <leader>'  viW<esc>`>a'<esc>`<i'<esc>`>e")

vim.cmd('nnoremap <leader>*  viW<esc>`>a*<esc>`<i*<esc>`>e')

-- vim.keymap.set("n", "<expr><leader>*", function ()
--     return "viw<esc>`>" .. vim.v.count1 .. "a*<esc>`<" .. vim.v.count1 .. "i*<esc>`>e";
-- end, { expr = true , noremap = true })

-- creates a visual mode mapping that surrounds visual mode selection with a character,
-- optionally using a different closing character if such was provided
local function gen_surround_keymap(character, closing)
    if closing ~= nil then
        vim.keymap.set("v", "<leader>" .. closing, function()
            return "<esc>`>" ..
                vim.v.count1 .. "a" .. closing .. "<esc>`<" .. vim.v.count1 .. "i" .. character .. "<esc>`>e";
        end, { expr = true })
    end
    closing = closing or character;
    vim.keymap.set("v", "<leader>" .. character, function()
        return "<esc>`>" .. vim.v.count1 .. "a" .. closing .. "<esc>`<" .. vim.v.count1 .. "i" .. character .. "<esc>`>e";
    end, { expr = true })
end

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

vim.cmd('nnoremap L  $')
vim.cmd('nnoremap H  ^')

vim.api.nvim_call_function('lexima#add_rule', {
    { char = '<', input_after = '>', filetype = 'html' }
})

vim.treesitter.language.register("glsl", "vert")

vim.cmd("match DiffDelete /\\v +$/")

-- vim.cmd('nnoremap <leader>cd  :cd %:p:h<cr>')
vim.keymap.set("n", "<leader>cd", "<cmd>:cd %:p:h<CR>")

--diagnostics
vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
vim.opt.signcolumn = 'yes:1'
