local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  -- completion = {
  --   autocomplete = false
  -- },
  formatting = {
    format = lspkind.cmp_format({
      --with_text = true, -- do not show text alongside icons
      mode = 'symbol_text',
      maxwidth = 45, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      -- preset = 'default',
      ellipsis_char = '...',
      symbol_map = {
        Class = "",
        Color = "",
        Constant = "",
        Constructor = "",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "",
        Interface = "",
        Keyword = "",
        Module = "",
        Method = "",
        Operator = "",
        Property = "",
        Reference = "",
        Snippet = "",
        Struct = "",
        Text = "",
        TypeParameter = "",
        Unit = "",
        Value = "V",
        Variable = "",
      },
    })
  },
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- ['K'] = cmp.mapping(function (fallback)
    --     if cmp.visible_docs() then
    --         cmp.close_docs()
    --     elseif cmp.visible() then
    --         cmp.open_docs()
    --     else
    --         fallback()
    --     end
    -- end),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({select = true}), { "i" }),
    -- scroll up and down the documentation window
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-i>'] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),
    -- Simple tab complete
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   local col = vim.fn.col('.') - 1

    --   if cmp.visible() then
    --     cmp.select_next_item({behavior = 'select'})
    --   elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    --     fallback()
    --   else
    --     cmp.complete()
    --   end
    -- end, {'i', 's'}),

    -- -- Go to previous item
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
  }),
})
